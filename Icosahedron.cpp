#include <vector>
#include <math.h>
#include <cstdio>

struct Point {double x,y,z;};
double c[] = {0.0, 1.0, (1+std::sqrt(5))/2, -1.0, -(1+std::sqrt(5))/2};
double dot(Point p, Point q) {return p.x*q.x + p.y*q.y + p.z*q.z;}
double norm2(Point p) {return dot(p,p);}
Point cross(Point p, Point q) {return {p.y*q.z-p.z*q.y, p.z*q.x-p.x*q.z, p.x*q.y-p.y*q.x};}
bool is_ico(Point p) {Point q={abs(p.x), abs(p.y), abs(p.z)}; return (q.x<q.y ? 1 : 0) + (q.y<q.z ? 1 : 0) + (q.z<q.x ? 1 : 0) == 2;}

const double r2 = norm2({c[0],c[1],c[2]});
std::vector<Point> vertices;
void init_vertices() {
   for(int i=0; i<5; ++i) {
      for(int j=0; j<5; ++j) {
         for(int k=0; k<5; ++k) {
            Point p = {c[i], c[j], c[k]};
            if(norm2(p) != r2) {continue;}
            if(!is_ico(p)) {continue;}
            vertices.push_back(p);
         }
      }
   }
}

const double d = dot({c[0],c[1],c[2]}, {c[1],c[2],c[0]});
struct Triangle {int a,b,c;}; // indices of vertices
std::vector<Triangle> faces;
void init_faces() {
   for(int i=0; i<vertices.size(); ++i) { Point vi = vertices[i];
      for(int j=0; j<i; ++j) { Point vj = vertices[j];
         if(dot(vi, vj) != d) {continue;}
         for(int k=0; k<j; ++k) { Point vk = vertices[k];      
            if(dot(vj, vk) != d) {continue;}
            if(dot(vk, vi) != d) {continue;} /*since k<j<i, this is technically redundant.*/
            if(dot(cross(vi, cross(vj,vi)), vj) <= 0) {continue;}
            faces.push_back({i,j,k});
         }
      }
   }
}

void main() {
   init_vertices();
   for(std::vector<Point>::const_iterator i=vertices.begin(); i!=vertices.end(); ++i) {
      printf("[%.4f,%.4f,%.4f],\n", i->x, i->y, i->z);
   } printf("\n");
   init_faces();
   for(std::vector<Triangle>::const_iterator i=faces.begin(); i!=faces.end(); ++i) {
      printf("[%d,%d,%d], \n", i->a, i->b, i->c);
   }
   char L; scanf_s("%c", &L);
}
