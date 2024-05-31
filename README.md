# Elbi Donation
A mobile application designed to facilitate in processing donations between donors and organizations. It has a database to track the status of each donations and donation drives, as well as relevant information about them. Organizations are verified through a screening process and submission of necessary documents. Donors can view details about the organizations available in the app that suit their needs.
## Installation Guide
### Building an Application Package (apk)
If you currently do not have a copy of the application package (apk), follow these steps to create one.
 1. Clone the Github repository - https://github.com/fambaridz/cmsc23-u1l-group4-project
 2. Open the project root directory in a terminal.
 3. Enter the following command in the terminal:
	`flutter build apk`
 4. Wait for it to finish building the apk.
 5. After it is done, the apk will be available in the following directory:
	`build\app\outputs\flutter-apk\app-release.apk` 
 
 After getting the apk, run the apk in your mobile device.

## User Guide
Upon opening the application, the user may sign in if they already have an existing (registered) account; otherwise, the user may opt to sign up as a donor or as an organization.

### Signing up as a donor
If the user chooses to sign up as a donor, they will automatically be signed in after providing the necessary information asked for. They can, then, view information about the registered organizations and choose which one they would like to send their donation/s to. Donors will be able to view the status of their donations on the donations page, and can also cancel their donations if it hasn't been confirmed by the organization yet.

### Signing up as an organization
Signing up as an organization will require the user to provide proof of the legitimacy of their organization, which will be submitted for reviewing by the admin. They will only be able to sign in to their account once the admin has approved their application. Once verified, the organization can sign in to their account to create organization drives and assign donations sent to their organization into these drives. They can also delete or change the status of the organization drives, as well as the status of their organization (whether open or closed for donations) if they choose to do so. The organization will have the ability to view the details, and can update the status of the donation/s unless the donors have cancelled it on their end.

## The Developers
### Mobile Marvels
Students of CMSC 23 U-1L in the University of the Philippines - Los Banos. Under the supervision of lecturer, Asst. Prof. Aldrin Joseph J. Hao, and laboratory instructor, Abigail C. Nadua.
 - Famela Anne Barida - https://github.com/fambaridz
 - Julia Katharine Borja - https://github.com/jk-borja
 - Aldrine Drebb Cristobal - https://github.com/AldCristobal

In partial fulfillment of the requirements in CMSC 23 - Mobile Programming course.
