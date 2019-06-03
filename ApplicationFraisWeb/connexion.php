<?php

header('Access-Control-Allow-Origin: *');
$host_name = 'localhost';
$database = 'gsb';
$user_name = 'root';
$password = 'root';

$bdd = new PDO("mysql:host=$host_name; dbname=$database;", $user_name, $password);

$query = $bdd->prepare('SELECT id, nom, prenom, login FROM utilisateur WHERE login = :nom_utilisateur AND mdp = :mot_de_passe;');
$query->bindParam(':nom_utilisateur', $_POST['nom_utilisateur']);
$query->bindParam(':mot_de_passe', md5($_POST['mot_de_passe']));
$query->execute();
$utilisateur = $query->fetch();

$retour = [];
if ($utilisateur['id'] != null) {
      $retour['succes'] = true;
      $retour['utilisateur_id'] = $utilisateur['id'];
      $retour['nom'] = $utilisateur['nom'];
      $retour['prenom'] = $utilisateur['prenom'];
      $retour['nom_utilisateur'] = $utilisateur['nom_utilisateur'];
}else{
      $retour['succes'] = false;
}

echo json_encode($retour);
