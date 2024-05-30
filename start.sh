#!/bin/sh

nginx


su -c "bash /app/start-app.sh" app
cd /app/log/

QED_LOGO=$(cat <<EOF     
    
            %%%  QED  %%.                                                                
        %%%              %%%                                                             
                                                                                         
    %%%                      %%%           ,ad8888ba,       88888888888     88888888ba,  
          d8'          \`8b                d8"'    \`"8b      88              88      \`"8b 
   %%%     d8'        \`8b      %%%       d8'        \`8b     88              88        \`8b
            d8========8b                 88          88     88aaaaa         88         88
  %%%        d8      8b        %%%       88          88     88"""""         88         88
              d8    8b                   Y8,    "88,,8P     88              88         8P
   %%%         d8  8b         %%%         Y8a.    Y88P      88              88      .a8P 
    %%          d88b          %%           \`"Y8888Y"Y8a     88888888888     88888888Y"'  
      %%%        db         %%                       '8a                                 
       %%%                %%%                                                            
          %%%%       %%%%                                                                
                %%%

                                [BitIDE v0.8.6]
    BitIDE is developed by QED, the team behind Bitcoin's zk-Powered Execution Layer
                     Learn more at https://qedprotocol.com

                 <For BitIDE Support, ping @QEDProtocol on twitter>


EOF
)
echo ""
echo "$QED_LOGO"
echo ""

echo "✅ BitIDE Started Successfully"
echo "Open http://localhost:1337/ in your web browser to start building!"

sleep 15

tail -f bitcoind electrs


