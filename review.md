# Users create and edit

1. Create a User model with `first_name`, `last_name`, `email`, and `password_digest`.
2. Add `has_secure_password` to the User model. Only then will we be able to use the `authenticate` method on users.
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
* GET /users/new -> `users#new`
  * Render `new.html.erb` (sign up form)
* POST /users -> `users#create` (submission of new form)
  * Saves user to database and redirects to root
  * Save the user id to the `session` object
* GET /users/:id/edit -> `users#edit` 
  * Render `edit.html.erb`
* PATCH /users/:id -> `users#update`
  * Updates user in database and redirects to root
* GET /users/:id/change_password -> `users#password_edit` 
  * Render `password_edit.html.erb`
* PATCH /users/:id/change_password -> `users#password_update`
  * Authenticate using `bcryipt`, `user&.authenticate` passing in the password
  * Updates password for user in database and redirects to root

6. Before actions:
* In `ApplicationController`, implement `current_user`, `user_signed_in?`, `authenticate_user!`.
  * Add helper methods to methods that you want your views to have access to
* Call `authenticate_user!` before authenticated routes such as edit and update, password_edit and password_update
  * Checks if there is a current_user, which exists if there is a user_id in the session
* Call `find_user`, set `@user` of the current user where you need it (edit/patch the user)
* Implement `ability.rb` and create a `can?` method to check if the current_user is the same user we're trying to update
  * Use that ability in `authorize`, and call authorize after you initialize the `@user`

# Session

1. Generate a `SessionController` to support rendering a login page, logging in 
and logging out. We don't need a model for session because it's not a table on our db.
2. Add routes to support actions related to sessions:

| HTTP VERB | Controller Action                   |
| --------- | ----------------------------------- |
| GET       | Read (new)                          |
| POST      | Create (create)                     |
| DELETE    | Delete (destroy)                    |

When adding the route for `session`, use singular `resource`. 
This will create routes that perform CRUD on a single resource. There won't index routes, or routes with wildcard `:id`.

3. Controller actions
* GET /session/new -> `sessions#new`
  * Render `new.html.erb` (login page)
* POST /session -> `sessions#create`
  * We don't have to require `:session` from params because it was 
  not included in our `form_with`, so we can access `:email` and `:password` from params like this: `params[:email]`
  * Authenticate using `bcryipt`, `user&.authenticate` passing in the password
  * Finds the user from the email entered
  * Save the user_id to the `session` object
  * Redirects to root page
* DELETE /session
  * Sets user_id in session to nil
  * Redirects to root page