import { enableProdMode } from '@angular/core';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';

import { AppModule } from './app/app.module';
import { environment } from './environments/environment';

import { initializeApp } from 'firebase/app';
import { getDatabase } from "firebase/database";

// Set the configuration for your app
// TODO: Replace with your project's config object
const firebaseConfig = {
  apiKey: environment.FB_API_KEY,
  authDomain: environment.FB_AUTH_DOMAIN,
  databaseURL: environment.FB_DB_URL,
  storageBucket: environment.FB_STOREAGE_BUCKET
};

const app = initializeApp(firebaseConfig);

// Get a reference to the database service
const database = getDatabase(app);

if (environment.production) {
  enableProdMode();
}

platformBrowserDynamic().bootstrapModule(AppModule)
  .catch(err => console.error(err));

/*
Copyright Google LLC. All Rights Reserved.
Use of this source code is governed by an MIT-style license that
can be found in the LICENSE file at https://angular.io/license
*/