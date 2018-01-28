# Building API with Rails
master: Use jbuilder and serializer building json response. Plain API that can be accessed anonymously.

jwt-AUTH_METHOD: Different approaches using Json Web Token to do authentication before accessing API.
## Plain API
Just mind the namespace. Without explicitly implementing `show`, it goes to corresponding path to fetch the template. In our case there is just `show.json.jbuilder`.
## Authentication
By and large, authentication consists of two steps.
1. User signs in to retrieve JWT by send a POST form.
2. User accesses API with the JWT gained in step 1.
### Authentication with Knock
Coming soon. [docs][0]
### Authentication with Devise&Warden
We use Devise authentication system built on top of Warden to do the Json Web Token authentication for us. User signing in to acquire JWT is done the same old way which does not have anything to do with Devise.
#### Custom Strategies
We can customize Devise provided strategies or build our own to feed to Warden. In general for a strategy two methods can be defined. `valid?` is optional and `authenticate!` is a must. In our case we just call `authenticate_user!` and it works out of box. Why is that? How does Devise defined `authenticate_user!` utilize our custom strategies under the hood?
##### Feed strategy to Warden
When you feed your strategy to Warden, `Warden::Strategies#add` is called to store it.
##### `authenticate_user!`
Internally, it calls `env['warden'].authenticate!`. env['warden'] is an object that can interact with you to do authentication. It is a `Proxy` object that is defined in Warden.
##### `Proxy#authenticate!`
This method will dynamically decide which strategies to call to do the authentication. It calls `valid?`. If it's not defined by you that's fine because Warden provides one that always returns true. After calling `valid?` it will execute `YOUR_STRATEGY._run!` which internally calls your custom `authenticate!`.
## ActiveModelSerializers and Sinatra
Be sure to check out [docs][1].

With serializers implemented, `render json: @location` calls the corresponding serializer to generate the json response. Switch between adapters in `/config/initializers`.
## VueJS interacts with API
Coming soon.

---
[0]: https://github.com/nsarno/knock
[1]: https://github.com/rails-api/active_model_serializers/tree/0-10-stable
