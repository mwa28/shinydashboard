# Guide de l'utilisateur

Bienvenue au guide d'emploi de TdB Costco ! La direction générale d'une enseigne de vente en ligne a fait appel à vous afin de valoriser son patrimoine data et de permettre à la DG de piloter l'activité économique à l'aide d'un dashboard intéractif en utilisant R shiny (front end) et le package Tidyverse + les R built-in functions (en backend).

Voici un overview du dashboard : 

![Dashboard](dashboard.png)

Les filtres choisis sont sur l'année et le mois de la commande.

Dans un premier temps, nous allons vous expliquer le layout du dashboard par visuel.

![infoBox](infoBox.png)

Dans ces boites, on peut voir des chiffres clés de la vente. La première montre le nombre d'utilisateurs distincts, la deuxième le nombre de ventes total, la troisième le profit annuel et la final la quantité vendue. Tous les nombres sont filtrables par année depuis le filtre du sidebar `Année de Commande`. Entre parenthèse nous avons l'évolution par rapport à l'année précedente (de celle choisi à gauche).

Ces variables montrées dans nos boites sont nos indicateurs clés. Pour les prochains visuels, il est possible de choisir sur quelle variable se focaliser dans les visuels.

![variable observee](var_obs.png)

## Visuel 1 - Évolution annuelle

![evolution annuelle](plot1.png)

Dans ce visuel, notre y est, comme mentionné, choisi dans la variable observée. Les lignes représentent l'année de commande choisi dans les filtres et l'année précedente pour comparer la performance hebdomadaire.

## Visuel 2 - Repartition par categorie

![repartition par categorie](pie_cat.png)

Dans ce visuel, nous nous mettons sur le sujet de comparaison de la variable souhaitée par catégorie des produits. Cela nous permet de mesurer la performance de chaque catégorie pour connaitre nos stars, filtrable par mois et année.

## Visuel 3 - Cartographie

![map](carto.png)

Finalement, nous pouvons mesurer la performance de nos rayons par pays pour mieux comprendre la popularité par pays.