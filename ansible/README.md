# Ansible Playbook for ChemVR Deployment

This Ansible playbook automates the deployment of the ChemVR application to a remote server.

## Prerequisites

1. Ansible installed on your local machine
2. SSH access to the target server(s)
3. Python 3.x on the target server(s)
4. Sudo privileges on the target server(s)

## Directory Structure

```
ansible/
├── inventory.ini          # Inventory file with server details
├── site.yml              # Main playbook
├── vars/
│   └── main.yml          # Variable definitions
└── roles/
    ├── common/           # Common system setup
    ├── nodejs/           # Node.js and pnpm installation
    ├── firewall/         # Firewall configuration
    ├── app_user/         # Application user setup
    └── deploy/           # Application deployment
```

## Usage

1. Edit the `inventory.ini` file and replace the IP address with your server's IP
2. Update the `vars/main.yml` with your specific configuration
3. Run the playbook:

```bash
ansible-playbook -i inventory.ini site.yml
```

## What This Playbook Does

1. **Common System Setup**
   - Updates package index
   - Installs required system packages
   - Configures timezone

2. **Node.js Installation**
   - Adds NodeSource repository
   - Installs Node.js and npm
   - Installs pnpm globally

3. **Firewall Configuration**
   - Sets up UFW (Uncomplicated Firewall)
   - Allows SSH and application ports
   - Enables the firewall

4. **Application User Setup**
   - Creates a dedicated system user for the application
   - Sets up proper permissions
   - Configures SSH access for deployment

5. **Application Deployment**
   - Clones the repository
   - Installs dependencies
   - Configures environment variables
   - Builds the application
   - Sets up systemd service
   - Enables and starts the service

## Variables

Edit `vars/main.yml` to customize the deployment:

- `app_user`: System user for the application
- `app_dir`: Installation directory
- `nodejs_version`: Node.js version to install
- `app_port`: Port for the application
- `firewall_allowed_ports`: List of ports to allow through the firewall

## Security Notes

1. The playbook creates a dedicated user with limited privileges
2. Sensitive information should be stored in Ansible Vault or environment variables
3. The firewall is configured to allow only necessary ports
4. The application runs under a non-root user

## Troubleshooting

- If the playbook fails, check the error message and verify the target server's configuration
- Make sure the target server is accessible via SSH
- Check system logs on the target server: `journalctl -u chemvr -f`

## License

This project is licensed under the MIT License.
