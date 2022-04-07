import { Component } from '@angular/core';

import { products } from '../models/products';

import { getDatabase, ref, set, get, child } from "firebase/database";

@Component({
  selector: 'app-product-list',
  templateUrl: './product-list.component.html',
  styleUrls: ['./product-list.component.css']
})
export class ProductListComponent {
  products = products;

  share() {
    this.writeUserData('12323', 'derek', 'derek@gmail.com', 'https://awefe2j2j2');
    window.alert('The product has been shared!');
  }

  onNotify() {
    this.readUserData('12323');
    window.alert('You will be notified when the product goes on sale');
  }

  writeUserData(userId: string, name: any, email: any, imageUrl: any) {
    const db = getDatabase();
    set(ref(db, 'users/' + userId), {
      username: name,
      email: email,
      profile_picture : imageUrl
    });
  }

  readUserData(userId: string) { 
    const dbRef = ref(getDatabase());
    get(child(dbRef, `users/${userId}`)).then((snapshot) => {
      if (snapshot.exists()) {
        console.log(snapshot.val());
      } else {
        console.log("No data available");
      }
    }).catch((error) => {
      console.error(error);
    });
  }
}


/*
Copyright Google LLC. All Rights Reserved.
Use of this source code is governed by an MIT-style license that
can be found in the LICENSE file at https://angular.io/license
*/