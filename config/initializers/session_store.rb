# Be sure to restart your server when you modify this file.
#
# To address warning in Firefox browser console.
# The error:
# Cookie “_bldgaccess_session” will be soon rejected because it has the “SameSite”
# attribute set to “None” or an invalid value, without the “secure” attribute. To
# know more about the “SameSite“ attribute, read
# https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie/SameSite
# Specify cookies SameSite protection level: either :none, :lax, or :strict.

Rails.application.config.session_store :cookie_store,
                                       key: '_depot8_session',
                                       same_site: :lax,
                                       expire_after: 9.hours