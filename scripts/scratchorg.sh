## CREATE SCRATCH ORG
project="rh-pirlde"
branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
scratchOrgName="$project-$branch"

# sf org create scratch -f [SCRATCH ORG DEF PATH] -a [ORG ALIAS] -y [DAYS ACTIVE] -w [WAIT TIME IN MINUTES]
sf org create scratch -f ./config/project-scratch-def.json -a "$scratchOrgName" -y 30 -w 60 -d

## DEPLOY FORCEAPP
# sf project deploy start -d [PATH] -o [TARGET ORG]
sf project deploy start -d force-app -o "$scratchOrgName"

## Assign System Admin a role in the role hierarchy
# sf apex run -f ./scripts/apex/EstablishRoleHierarchy.apex

## DEPLOY PERMISSION SETS TO SO
# sf project deploy start -d PostDeployPermissionSets

## Assign permission sets to admin user
# sf apex run -f ./scripts/apex/AssignAdminPermissionSet.apex

## DEPLOY TEST DATA
# sf apex run -f ./scripts/apex/Accounts.apex
# sf apex run -f ./scripts/apex/Contacts.apex
# sf apex run -f ./scripts/apex/Skills.apex
# sf apex run -f ./scripts/apex/Jobs.apex
# sf apex run -f ./scripts/apex/Events.apex
# sf apex run -f ./scripts/apex/JobApplications.apex

## ! ADD NEW SETUP STEPS HERE 


## TODO Add Enable Customer User & Log in to Experience Site as User quick actions to Contact Employer page layout


## TODO Activate the community -- likely to remain a manual step
## TODO Adjust Membership for community to include Customer Community Plus -- possibly covered through experiencebundle deployment


## TODO Update Preferences in the community -- possibly covered through experiencebundle deployment
## TODO Enable self registration in the Login Settings of the Community, select Customer Community Plus for Profile -- possibly covered through experiencebundle deployment
## TODO Deploy cloned community (for themes/branding, component properties, etc) 
## TODO Update the Home page custom metadata to reference the base org url -- can be scripted using getInstance() and retrieving the base org url using the URL class method getOrgDomainUrl()


## TODO Configure ONET External Credential authorization
    ## radianHub
    ## 5493pir

## TODO OWD/Sharing Set
    ## Change OWD Contact to Private/Private
    ## Add Contact to Experience Sharing Set
        ## User.Contact = Contact.Id
    ## Add Community profile

## TODO Resume Builder Page Configuration metadata
    ## Change Record Type Id to Contact Job Seeker RT Id

## TODO
    ## Open org after complete