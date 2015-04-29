<p align="center">
  <img src="https://cloud.githubusercontent.com/assets/794809/7395239/b36379d4-ee66-11e4-8778-28fa95663a61.gif" alt="Blastoff Rocket" />
</p>

# WordPress Blastoff
#### Modern Wordpress Development

### About WP Blastoff?

This repository serves as a jumping off point in WordPress development. A modern development workflow should be fully version controlled and provide multiple environments. It should also provide a straightforward deployment solution as well as be easily maintainable as the project matures. This is what we hope to achieve with **WordPress Blastoff**. A repo that will help bootstrap your WordPress projects, but provide the flexibility and customization to accomodate your specific needs.

### What is involved?

Below are the main components of the project:

- Local environment setup with [Vagrant](https://www.vagrantup.com/)
- Deployment and Apache provisioning to both Staging and Production environments with [Mina](http://mina-deploy.github.io/mina/)
- Incredibly easy WordPress core updates (coming soon)

## Getting Started

To begin, we'll create our **production** server. Since the goal is to mirror our production environment, we'll use this to then setup our other environments. So let's get to it!

### Creating a Digital Ocean Production Droplet

![digitalocean-logo](https://cloud.githubusercontent.com/assets/794809/7399340/186ea710-ee83-11e4-8700-6ff167c3ffb1.png)

Your choice of a production server is up to you, but we highly recommend using [Digital Ocean](https://www.digitalocean.com/). It provides a dead-simple VPS setup with out-of-the-box WordPress support. Follow the instructions on the website and create a droplet. Our default image includes an Ubuntu distro along with the latest version of Wordpress (found under **Applications** tab within the *Select Image* section.

![digitalocea-droplet](https://cloud.githubusercontent.com/assets/794809/7400011/d6ad02d6-ee87-11e4-8360-e959279123d1.png)












