# Building API with Rails
## Authentication
### Authentication with Devise&Warden
We use Devise authentication system built on top of Warden to do the Json Web Token authentication for us. User signing in to acquire JWT is done the same old way which does not have anything to do with Devise.
#### Custom Strategies
We can customize Devise provided strategies or build our own to feed to Warden. In general for a strategy two methods can be defined. `valid?` is optional and `authenticate!` is a must. In our case we just call `authenticate_user!` and it works out of box. Why is that? How does Devise defined `authenticate_user!` utilize our custom strategies under the hood?
##### `authenticate_user!`
Internally, it calls `env['warden'].authenticate!`. env['warden'] is an object that can interact with you to do authentication. It is a `Proxy` object that is defined in Warden.
##### `Proxy#authenticate!`
This method will dynamically decide which strategies to call to do the authentication. It calls `valid?`. If it's not defined by you that's fine because Warden provides one that always returns true. After calling `valid?` it will execute `YOUR_STRATEGY._run!` which internally calls your custom `authenticate!`
