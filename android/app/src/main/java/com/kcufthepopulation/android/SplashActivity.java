package com.kcufthepopulation.android;

import android.support.v7.app.AppCompatActivity;
import android.content.Intent;
import android.os.Bundle;
<<<<<<< HEAD
import android.content.Intent;
=======
>>>>>>> 63e3b497d9079acc38548cf9688567fc6df87e8f
import android.os.Handler;

public class SplashActivity extends AppCompatActivity {

    private static int SPLASH_TIME_OUT = 3000;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);

        new Handler().postDelayed(new Runnable() {
<<<<<<< HEAD
=======

>>>>>>> 63e3b497d9079acc38548cf9688567fc6df87e8f
            @Override
            public void run() {
                Intent i = new Intent(SplashActivity.this, MainActivity.class);
                startActivity(i);
<<<<<<< HEAD

                finish();
            }
        }, SPLASH_TIME_OUT);
=======
>>>>>>> 63e3b497d9079acc38548cf9688567fc6df87e8f

                finish();
            }
        }, SPLASH_TIME_OUT);

    }
}
