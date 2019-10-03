#version 430
layout(triangles) in;layout(triangle_strip, max_vertices = 6) out;

in Attribs {
    vec4 couleur;
	float sortie1, sortie2;
} AttribsIn[];

out Attribs {
    vec4 couleur;
} AttribsOut;


void main()
{
    // emettre les sommets
    for ( int i = 0 ; i < gl_in.length() ; ++i )
    {
        gl_ViewportIndex = 0;
        gl_Position = gl_in[i].gl_Position;
        AttribsOut.couleur= AttribsIn[i].couleur;
        gl_ClipDistance[0] = AttribsIn[i].sortie1;
		gl_ClipDistance[1] = AttribsIn[i].sortie2;
        EmitVertex();
    }
    EndPrimitive();

    for ( int i = 0 ; i < gl_in.length() ; ++i )
    {
        gl_ViewportIndex = 1;
        gl_Position = gl_in[i].gl_Position;
		AttribsOut.couleur= vec4 (1.0 - AttribsIn[i].couleur[0], 1.0- AttribsIn[i].couleur[1], 
									1.0- AttribsIn[i].couleur[2], AttribsIn[i].couleur[3]);
		gl_ClipDistance[0] = AttribsIn[i].sortie1;
		gl_ClipDistance[1] = AttribsIn[i].sortie2;
        EmitVertex();
    }
    EndPrimitive();
}