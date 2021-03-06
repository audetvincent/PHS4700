classdef Voiture
    % Classe detaillant une voiture.
    
    properties
        m % La masse (kg)
        L % La longueur (m)
        l % La largeur (m)
        h % La hauteur (m)
        r % La position (m)
        rAng % L'angle par rapport a l'axe x (radians)
        v % La vitesse (m/s)
        vAng  % La vitesse angulaire (radians/s)
        I % Matrice du moment d'intertie.
    end
    
    methods
        function voiture = Voiture(m,L,l,h,r,rAng,v,vAng)
            voiture.m = m;
            voiture.L = L;
            voiture.l = l;
            voiture.h = h;
            voiture.r = r;
            voiture.rAng = rAng
            voiture.v = v;
            voiture.vAng = vAng;
            voiture.I = [m/12*(l^2 + h^2) 0 0; 0 m/12*(L^2 + h^2) 0; 0 0 m/12*(L^2 + l^2)];
        end
        
        function plans = getPlans(this)
          %retourne une matrice dont chaque ligne est un vecteur correspondant a [p1 p2 q1] (qui sont eux-memes des vecteurs)
            R = [cos(-this.rAng) -sin(-this.rAng) 0; sin(-this.rAng) cos(-this.rAng) 0; 0 0 1];
            %plan avant(cote court vers +x):
            q1 = ([this.r 0] + [this.L/2 this.l/2 this.h]*R);
            q2 = ([this.r 0] + [this.L/2 this.l/2 0]*R);
            q3 = ([this.r 0] + [this.L/2 -this.l/2 0]*R);
            p1 = q1 - q2;
            p2 = q1 - q3;
            plan1 = [p1 p2 q1];
            
            %plan arriere(cote court vers -x):
            q1 = ([this.r 0] + [-this.L/2 -this.l/2 this.h]*R);
            q2 = ([this.r 0] + [-this.L/2 -this.l/2 0]*R);
            q3 = ([this.r 0] + [-this.L/2 this.l/2 0]*R);
            p1 = q1 - q2;
            p2 = q1 - q3;
            plan2 = [p1 p2 q1];
            
            %plan gauche(cote long vers -y):
            q1 = ([this.r 0] + [this.L/2 -this.l/2 this.h]*R);
            q2 = ([this.r 0] + [this.L/2 -this.l/2 0]*R);
            q3 = ([this.r 0] + [-this.L/2 -this.l/2 0]*R);
            p1 = q1 - q2;
            p2 = q1 - q3;
            plan3 = [p1 p2 q1];
            
            %plan droit(cote long vers +y):
            q1 = ([this.r 0] + [-this.L/2 this.l/2 this.h]*R);
            q2 = ([this.r 0] + [-this.L/2 this.l/2 0]*R);
            q3 = ([this.r 0] + [this.L/2 this.l/2 0]*R);
            p1 = q1 - q2;
            p2 = q1 - q3;
            plan4 = [p1 p2 q1];
            
            plans = [plan1; plan2; plan3; plan4];
            
        end
        
        function coins = getCoins(this)
          %retourne une matrice dont les lignes sont les vecteurs correspondant aux 4 coins du solide situes a z=0.
            R = [cos(-this.rAng) -sin(-this.rAng) 0; sin(-this.rAng) cos(-this.rAng) 0; 0 0 1];
            coin1 = ([this.r 0] + [this.L/2 this.l/2 0]*R);
            coin2 = ([this.r 0] + [-this.L/2 this.l/2 0]*R);
            coin3 = ([this.r 0] + [this.L/2 -this.l/2 0]*R);
            coin4 = ([this.r 0] + [-this.L/2 -this.l/2 0]*R);
            coins = [coin1; coin2; coin3; coin4];
        end
        
        function IInv = getIInv(this)
          %retourne la matrice du moment d'inertie inversee. 
            R = [cos(-this.rAng) -sin(-this.rAng) 0; sin(-this.rAng) cos(-this.rAng) 0; 0 0 1];
            IInv = inv(R*this.I*transpose(R));
        end
        
        function dessiner(this, couleur)
          %dessine la voiture sur un graphique.
            hold on
            R = [cos(-this.rAng) -sin(-this.rAng) 0; sin(-this.rAng) cos(-this.rAng) 0; 0 0 1];
            coin1 = ([this.r 0] + [this.L/2 this.l/2 0]*R);
            coin2 = ([this.r 0] + [-this.L/2 this.l/2 0]*R);
            coin3 = ([this.r 0] + [-this.L/2 -this.l/2 0]*R);
            coin4 = ([this.r 0] + [this.L/2 -this.l/2 0]*R);
            
            x = [coin1(1),coin2(1),coin3(1),coin4(1)];
            y = [coin1(2),coin2(2),coin3(2),coin4(2)];
            fill(x,y,couleur);
        end
    end
end

