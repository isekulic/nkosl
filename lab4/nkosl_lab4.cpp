#include <iostream>
#include <security/pam_modules.h>
#include <security/pam_appl.h>
#include <ctime>
#include <fstream>

using namespace std;

int main(int argc, char const *argv[]){

    pam_handle_t *pamh;
    struct pam_conv pamc;
    string username, password;
    myfile.open("history.txt");

    time_t result;

    pam_start ()

    if (pam_authenticate(pamh, 0) == PAM_SUCCESS){
        cout << "Tvoja Mama: +385 97 753 3024";
        result = time(NULL);
        myfile << asctime(localtime(&result)) << endl << username << endl;
    }

    else {
        cout << "Greška pri autentifikaciji." << endl;
        result = time(NULL);
        myfile << asctime(localtime(&result));
    }


    myfile.close();
    return 0;
}