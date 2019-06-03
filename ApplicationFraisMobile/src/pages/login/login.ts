import { FicheFraisPage } from './../fiche-frais/fiche-frais';
import { Utilisateur } from './../../models/utilisateur';
import { Component } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { IonicPage, NavController, ToastController } from 'ionic-angular';

import { User } from '../../providers';
import { MainPage } from '../';

@IonicPage()
@Component({
  selector: 'page-login',
  templateUrl: 'login.html'
})
export class LoginPage {
  
  utilisateur = new Utilisateur();

  constructor(public navCtrl: NavController,
    public user: User,
    public toastCtrl: ToastController,
    public translateService: TranslateService) {
      
  }

  doLogin() {
    this.user.login(this.utilisateur).subscribe((resp) => {
      if (resp['succes']) {
        this.user.utilisateurId = resp['utilisateur_id'];
        this.user.nom = resp['nom'];
        this.user.prenom = resp['prenom'];
        this.user.nomUtilisateur = resp['nom_utilisateur'];
        this.navCtrl.push('TabsPage');
      }else{
        let toast = this.toastCtrl.create({
          message: 'Identifiants incorrects',
          duration: 3000,
          position: 'bottom'
        });
        toast.present();
      }
    }, (err) => {
      let toast = this.toastCtrl.create({
        message: 'Une erreur est survenue',
        duration: 3000,
        position: 'bottom'
      });
      toast.present();
    });
  }
}
