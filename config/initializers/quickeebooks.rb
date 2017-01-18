QB_KEY = "lvprdOdMIaZqLDF8ponMS8SahAaavk"
QB_SECRET = "rm9dmkucqGDEROUBwAipIDizYwuT9TiSkJ5KhAjP"

$qb_oauth_consumer = OAuth::Consumer.new(QB_KEY, QB_SECRET, {
    :site                 => "https://oauth.intuit.com",
    :request_token_path   => "/oauth/v1/get_request_token",
    :authorize_url        => "https://appcenter.intuit.com/Connect/Begin",
    :access_token_path    => "/oauth/v1/get_access_token"
})