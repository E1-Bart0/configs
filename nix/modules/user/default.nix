# User configuration centralized in one place
rec {
  username = "starova1";
  homeDirectory = "/Users/${username}";
  description = "Primary user account";
  
  # Add any other user-specific settings here
  # This makes it easy to change user information in one place
  # The 'rec' keyword allows attributes to reference other attributes
}