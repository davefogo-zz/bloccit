if Rails.env.development? || Rails.env.production?
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
      address:        'smtp.mandrill.net',
      port:           '587',
      authentication: :plain,
      user_name:      ENV['MANDRILL_USERNAME'],
      password:       ENV['MANDRILL_PASSWORD'],
      domain:         'heroku.com',
      enable_starttls_auto: true
    }
end
