# Users create and edit

1. Create a User model with `first_name`, `last_name`, `email`, and `password_digest`.
2. Add `has_secure_password` to the User model.
3. Generate a `UsersController`.
4. Add routes to support actions related to users:

| HTTP VERB | Controller Action                   |
| --------- | ----------------------------------- |
| GET       | Read (new, edit, password_edit)     |
| POST      | Create (create)                     |
| PATCH     | Update (update, password_update)    |
| DELETE    | Delete (destroy)                    |

We can optionally add a show page for a user and redirect to the show page instead of the root

5. Controller actions
GET /users/new -> `new`
  * Render `new.html.erb`
POST /users -> `create` (submission of new form)
  * Saves user to database and redirects to root
  * Save the user id to the `session` object
GET /users/:id/edit -> `edit` 
  * Render `edit.html.erb`
PATCH /users/:id -> `update`
  * Updates user in database and redirects to root
GET /users/:id/change_password -> `password_edit` 
  * Render `password_edit.html.erb`
PATCH /users/:id/change_password -> `password_update`
  * Updates password for user in database and redirects to root

6. Before actions:
* In `ApplicationController`, implement `current_user`, `user_signed_in?`, `authenticate_user!`.
  * Add helper methods to methods that you want your views to have access to
* Call `authenticate_user!` before authenticated routes such as edit and update, password_edit and password_update
  * Checks if there is a current_user, which exists if there is a user_id in the session
* Call `find_user`, set `@user` of the current user where you need it (edit/patch the user)
* Implement `ability.rb` and create a `can?` method to check if the current_user is the same user we're trying to update
  * Use that ability in `authorize`, and call authorize after you initialize the `@user`