# sign in
# sign out
# register
# providers can claim an organisation
# provider can be sent fax, text to landline, snail mail, ask for phone call, rescan
# provider can enter access code for single org, multiple orgs
# provider can only enter 3 incorrect codes before it gets barred
# if 3 incorrect attempts are made message admin
# service form should handle links to all 4 regulators properly
# create organisation
# show service
# changing password
# resetting password
# not logged in comment on a service with duplicate email.  At /rates/record do a refresh.  (It was getting exception ActiveRecord::RecordNotFound in RatesController#show)

#button_to(name, options = {}, html_options = {})
#Generates a form containing a single button that submits to the URL created by the set of options. This is the safest method to ensure links that cause changes to your data are not triggered by search bots or accelerators. If the HTML button does not work with your layout, you can also consider using the link_to method with the :method modifier as described in the link_to documentation.
