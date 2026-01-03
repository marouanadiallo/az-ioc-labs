# Déploiement de trois ressources - IoC via Bicep

La branche main centralise aujourd’hui les déclarations brutes des ressources. Nous visons à modulariser ce template d’approvisionnement pour un site standard, en tirant parti des paramètres, variables et expressions Bicep.

La progression du projet est organisée par étapes, chacune étant représentée par une branche dédiée :

- *paramsAndVars* : Intègre les paramètres et variables pour dynamiser les déclarations de ressources.
- *splitIntoMod* : Découpe le template en modules réutilisables, conformément aux bonnes pratiques Bicep pour un site classique.

> source : [learn.microsoft.com](https://learn.microsoft.com/fr-fr/training/paths/fundamentals-bicep/)


## Tâches de cette branche

Ci-dessous l'ensemble de tâches réalisées sur cette branche :

- [x] Ajoutez des paramètres sécurisés
- [x] Créez un fichier de paramètres
- [x] Testez le déploiement pour vous assurer que le fichier de paramètres est valide.
- [x] Créez un coffre de clés et des secrets.
- [x] Mettez à jour le fichier de paramètres pour faire référence aux secrets du coffre de clés.
- [x] Testez à nouveau le déploiement pour vous assurer que le fichier de paramètres est toujours valide.

Une fois les tâches réalisées, déployer avec la commande suivante :

>```
> az deployment group create\  
>   -g yourResourceGroupName\
>   --name main\
>   --template-file main.bicep\
>   --parameters main.parameters.dev.json
>```
