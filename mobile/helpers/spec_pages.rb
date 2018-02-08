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
def inbox_primary
  return "[aria-label='Primary']"
end

def inbox_logo
  return "[href='#inbox']"
end

def ios_missing_msg
  return "[aria-label='Primary']"
end
