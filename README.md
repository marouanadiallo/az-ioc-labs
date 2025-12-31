# Déploiement de trois ressources - IoC via Bicep

La branche main centralise aujourd’hui les déclarations brutes des ressources. Nous visons à modulariser ce template d’approvisionnement pour un site standard, en tirant parti des paramètres, variables et expressions Bicep.

La progression du projet est organisée par étapes, chacune étant représentée par une branche dédiée :

- *paramsAndVars* : Intègre les paramètres et variables pour dynamiser les déclarations de ressources.
- *splitIntoMod* : Découpe le template en modules réutilisables, conformément aux bonnes pratiques Bicep pour un site classique.

## Tâches de cette branche

Ci-dessous l'ensemble de tâches réalisées sur cette branche :

[ x ] Mettez à jour le fichier Bicep pour inclure un `location` paramètre.\
[ x ] Mettez à jour le fichier Bicep pour inclure des paramètres et des variables pour les noms de ressources.\
[ x ] Utiliser des expressions pour définir les valeurs par défaut des paramètres.\
[ x ] Mettez à jour le fichier Bicep pour inclure des variables pour la référence SKU de chaque ressource.\
[ x ] Testez le déploiement pour s'assurer que le fichier Bicep est valide.

Une fois les tâches réalisées, déployer avec la commande suivante :

` az deployment group create 
    --name main 
    --template-file main.bicep 
    --parameters environmentType=nonprod`