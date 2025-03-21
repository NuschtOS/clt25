{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
  };

  users.users.root.openssh.authorizedKeys.keys = [
    # sandro
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFidD6Snqgd8J7avxHvdDd81rdi0zNZWSilBe3eaTIlv sandro@magnesium"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIAUDvmdH7DwqMXLg/fAXtwme44P5L6ye9dFcVIdL+wk5AAAABHNzaDo= geode"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIDZVEPkbVT3+g5PEngQ4HSmXWBppmoAYuDIrZrPYMeXrAAAABHNzaDo= prism"
    # goeranh
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGv/oVZzyevF6wrYQLYpTtov8pMiY9A5O3/91bAGvGmZ goeranh@node5"
    # marcel
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK255EY8KUx5cMXSuoERXJSzVnkDUM+y8sMAVrRoDBnn"
  ];
}
