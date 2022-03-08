# Bugzilla

User Authentication managed through Devise
User Aiuthorization manages through Pundit
User Roles managed through Rolify
Image Uploads are handled through Active Storage
Images are stored on cloud through Cloudinary
Search Bars are handled through AJAX and pg_search
UI Design is mostly done through Bootstrap, but CSS is used where needed
Active Mailer is integrated to send email to user when he/she is assigned/removed from a Project
User can have many Roles ( from Manager, QA, Developer)
A Role can have many many users
Manager can have many projects
QA can report many bugs
A bug has a creator
A bug has a Developer who'll solve the bug
A developer can assign a bug to himself
A bug belongs to a project
A project can have many users
A project can have many bugs
A user has an email, name, and password
A project has a name and a description
A bug has a title, description, deadline, screenshot, type, and status
The title of a bug is unique throughout the project
Type can have two values (feature, bug)
Status is a drop down having values (new, started, completed) if it's a feature or (new, started and resolved) if it's a bug (Handled through JS)
