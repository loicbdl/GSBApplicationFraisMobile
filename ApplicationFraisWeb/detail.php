<?php

header('Access-Control-Allow-Origin: *');
$host_name = 'localhost';
$database = 'gsb';
$user_name = 'root';
$password = 'root';

$bdd = new PDO("mysql:host=$host_name; dbname=$database;", $user_name, $password);

$queryDFF = $bdd->prepare('
      SELECT detail_frais_forfait.id as id, detail_frais_forfait.quantite as quantite, detail_frais_forfait.etat_id as etat, frais_forfait.montant as montant, frais_forfait.libelle as libelle
      FROM detail_frais_forfait
      INNER JOIN frais_forfait ON detail_frais_forfait.frais_forfait_id = frais_forfait.id
      WHERE fiche_frais_id = :fiche_frais_id
');
$queryDFF->bindParam(':fiche_frais_id', $_GET['fiche_frais_id']);
$queryDFF->execute();
$detailFraisForfait = $queryDFF->fetchAll();

$queryDFNF = $bdd->prepare('SELECT * FROM detail_frais_non_forfait WHERE fiche_frais_id = :fiche_frais_id');
$queryDFNF->bindParam(':fiche_frais_id', $_GET['fiche_frais_id']);
$queryDFNF->execute();
$detailFraisNonForfait = $queryDFNF->fetchAll();

$total = 0;

$retour = [
      'detail_frais_forfait' => array(),
      'detail_frais_non_forfait' => array()
];
for ($i=0; $i < count($detailFraisForfait); $i++) {
      $total = $total + ($detailFraisForfait[$i]['quantite'] * $detailFraisForfait[$i]['montant']);

      $datas = array(
            'id' => $detailFraisForfait[$i]['id'],
            'quantite' => $detailFraisForfait[$i]['quantite'],
            'montant' => $detailFraisForfait[$i]['montant'],
            'libelle' => $detailFraisForfait[$i]['libelle'],
            'etat' => $detailFraisForfait[$i]['etat']
      );

      array_push($retour['detail_frais_forfait'], $datas);
}

for ($j=0; $j < count($detailFraisNonForfait); $j++) {
      $total = $total + $detailFraisNonForfait[$j]['montant'];
      $datas = array(
            'id' => $detailFraisNonForfait[$j]['id'],
            'libelle' => $detailFraisNonForfait[$j]['libelle'],
            'montant' => $detailFraisNonForfait[$j]['montant'],
            'etat' => $detailFraisNonForfait[$j]['etat_id']
      );

      array_push($retour['detail_frais_non_forfait'], $datas);
}

$retour['total'] = $total;
echo json_encode($retour);
