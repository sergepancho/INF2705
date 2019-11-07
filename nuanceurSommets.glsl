#version 410

uniform mat4 matrModel;
uniform mat4 matrVisu;
uniform mat4 matrProj;

uniform vec4 planRayonsX; // équation du plan de RayonsX

uniform int attenuation; // on veut une atténuation en profondeur ?

layout(location=0) in vec4 Vertex;
layout(location=3) in vec4 Color;

out Attribs {

    vec4 couleur;
	float sortie1,sortie2;

} AttribsOut;

void main( void )
{
    // transformation standard du sommet
    gl_Position = matrProj * matrVisu * matrModel * Vertex;
	
    vec4 pos = matrModel * Vertex;

	AttribsOut.sortie1 = dot(planRayonsX, pos );
	AttribsOut.sortie2 = -dot(planRayonsX, pos );


    // couleur du sommet
    AttribsOut.couleur = Color;

	if(Color.a ==1.0){
		vec4 couleurvariable = vec4(0.0,1.0,1.0,1.0);//cyan
		float variable =smoothstep(0,1,Vertex.z);
		(AttribsOut.couleur).z=(mix(Color,couleurvariable,variable)).z;
	}

	//faire varier la couleur des poissons du vert au bleu

	/*if(AttribsOut.couleur.a == 1.0){
		vec4 couleurvariable = vec4(0.0,1.0,1.0,1.0);//cyan
		AttribsOut.couleur=mix(Color,couleurvariable,Vertex.z);
	}else
	{
		AttribsOut.couleur = Color;
	}*/
    // atténuer selon la profondeur
	/*
    if ( attenuation == 1 )
    {
		

		    const float debAttenuation = -12.0;
			const float finAttenuation = +5.0;
			vec4 coulAttenuation = vec4( 0.2, 0.15, 0.1, 1.0 );	
			
	   if(pos.z >debAttenuation && pos.z <finAttenuation  ){
			float value = smoothstep(debAttenuation,finAttenuation,pos.z);
			AttribsOut.couleur=mix(AttribsOut.Color,coulAttenuation,1-value);
			
		}
		if(pos.z<debAttenuation){
		
			AttribsOut.couleur=mix(AttribsOut.Color,coulAttenuation,1.0);
		}
         
    }

	//donner une couleur bleu au corps des poissons 
			const float deb = 0;
			const float fin = 1;
			vec4 coulvariable = vec4( 0.0, 1.0, 1.0, 1.0 );//cyan 
			float variable =smoothstep(deb,fin,Vertex.z);
			AttribsOut.couleur=mix(AttribsOut.Color,coulvariable,variable);

	 */


}
