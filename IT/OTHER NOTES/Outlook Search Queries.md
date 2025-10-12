To efficiently locate specific emails in Outlook, you can utilize the following search queries:

1. Find a conversation based on a subject
    1. ==[Conversation]:="INVOICE FOR TRM LICENSE”==
2. **Emails from Specific Senders**:
    - **Single Sender**: `from:"sender@example.com"`
    - **Multiple Senders**: `from:("sender1@example.com" OR "sender2@example.com")`
3. **Emails Sent to Specific Recipients**:
    - **Directly to You**: `to:your.email@example.com`
    - **Cc'd to You**: `cc:your.email@example.com`
    - **Bcc'd to You**: `bcc:your.email@example.com`
4. **Emails with Specific Subjects**:
    - **Exact Match**: `subject:"Meeting Agenda"`
    - **Containing Keywords**: `subject:(budget AND Q1)`
5. **Emails Containing Attachments**:
    - **With Any Attachment**: `hasattachment:yes`
    - **With Specific Attachment Name**: `attachments:report.pdf`
6. **Emails Within Date Ranges**:
    - **Before a Specific Date**: `received:<=01/31/2025`
    - **After a Specific Date**: `received:>=02/01/2025`
    - **Between Dates**: `received:>=01/01/2025 AND received:<=01/31/2025`
7. **Emails by Folder**:
    - **Specific Folder**: `folder:Inbox`
    - **Subfolders**: `folder:Inbox/ProjectX`
8. **Combining Multiple Criteria**:
    - **From Specific Sender with Attachments**: `from:"sender@example.com" AND hasattachment:yes`
    - **Subject Contains Keyword and Received This Week**: `subject:Update AND received:this week`

**Tips**:

- **Logical Operators**: Use `AND`, `OR`, and `NOT` to combine or exclude terms.
- **Wildcards**: Use to represent multiple characters in a keyword.
- **Quotation Marks**: Enclose phrases in quotes to search for exact matches.

For a comprehensive guide on Outlook's search capabilities, refer to Microsoft's official documentation: citeturn0search0

By mastering these search queries, you can streamline your email management and quickly locate the information you need.