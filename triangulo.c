#include<stdio.h>
#define TAMANO_MAXIMO 100
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
 

/*
-----------------------------------------------
funcion factok
----------------------------------------------
@ num es el parametro de la funcion
@i es la temporal de num
@ fact es el valor de la fila desde donde se va a empezar a formar el triangulo, por ejemplo si es 5 entonces desde la fila 5 se va a llenar a el tringulo

para cada i mayor a 1 se va a multiplicarr el fact por el numero que ingreso en la funcion



--------------------------------------------------

*/

int factok(long long int num)

{

    int i=num;

    int u=3;

    long long fact=1;

    for(i=num;i>1;i--)

    {
    	if(u==3){
    		fact*=i;
    	}
        

    }

    return fact;

}


/*
---------------------------------------
main
@i  numero de renglones
@j numero de elementos
@k numero de elementos

se pide un numero al usuario para ir formando el arbol de pascal
------------------------------------
*/

int main()

{

    int i,j=1,k=1; // i = renglones  j = elementos

    //se crea un arreglo de char
    char entrada[TAMANO_MAXIMO];

    //se pide al usuario que ingrese un valor
    printf("Ingrese un numero para formar el arbol binario de pascal: ");
    fgets(entrada,TAMANO_MAXIMO,stdin);

    //se transforma lo ingresado a entero
    int n=atoi(entrada);

    //el for va de 0 hasta el numero de elementos que ingreso el usuario

    for (i = 0; i < n; i++)

    {

    	//for que va desde 1 hasta el numero de elementos menos el numero de renglones
        for (j = 1; j < n-i; j++)
        	//se imprime un vacio por presentacion, para que tenga aspecto de arbol
        	printf ("");

        //llama a la funcion factok para que se vaya llenando el arbol de pascal
        for (k = 0; k <= i; k++)
        	//imprime el valor del factorial, el factorial
            printf ("%d ",(factok(i))/(factok(k)*(factok(i-k))));

        printf ("\n");

    }

}

 


