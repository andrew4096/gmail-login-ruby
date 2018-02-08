require "./helpers/spec_browser_ch.rb"

# login page
def header_text
  return '#headingText'
end

def input_login
  return 'input#identifierId'
end  

def language_selector
  return "[data-value='en']"
end

def id_next_btn
  return '#identifierNext'
end

# password page
def password_next_btn
  '#passwordNext'
end

def input_password
  return "input[name='password']"
end  

# mailbox page
def inbox_link
  return "[href='https://mail.google.com/mail/u/0/#inbox']"
end

def inbox_logo
  return "[href='#inbox']"
end
