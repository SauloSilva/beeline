# Cálculo do caminho mais curto - Entregando mercadorias

## Problema

A Companhia LevaEtraz está desenvolvendo um novo sistema de logistica e sua ajuda é muito importante neste momento. Sua tarefa será desenvolver o novo sistema de entregas visando sempre o menor custo. Para popular sua base de dados o sistema precisa expor um Webservices que aceite o formato de malha logística (exemplo abaixo), nesta mesma requisição o requisitante deverá informar um nome para este mapa. É importante que os mapas sejam persistidos para evitar que a cada novo deploy todas as informações desapareçam. O formato de malha logística é bastante simples, cada linha mostra uma rota: ponto de origem, ponto de destino e distância entre os pontos em quilômetros.

| From          | To            | Distance   |
| ------------- |:-------------:| ----------:|
| A             | B             | 10         |
| B             | D             | 15         |
| A             | C             | 20         |
| C             | D             | 30         |
| B             | E             | 50         |
| D             | E             | 30         |

Com os mapas carregados o requisitante irá procurar o menor valor de entrega e seu caminho, para isso ele passará o mapa, nome do ponto de origem, nome do ponto de destino, autonomia do caminhão **(km/l)** e o valor do litro do combustivel, agora sua tarefa é criar este Webservices. Um exemplo de entrada seria, mapa SP, origem A, destino D, autonomia **10**, valor do litro **2,50**; a resposta seria a rota `A B D` com custo de **6,25**.

## Solução

**Logistic network** é uma REST API feita em Rails responsável por guardar mapas, cidades, rotas e calcular o caminho mais curto entre dois pontos distintos.
Apliquei o algorítimo de Dijkstra para solucionar o problema do caminho mais curto num grafo dirigido com arestas.
Todas as respostas são entregues em formato `JSON`.

## Preparando o ambiente

````bash
gem install bundler && bundle
rake db:setup
rails s
````

## Tratamento de erros

Todos erros gerados por alguma requisição `POST`, `PUT` ou `DELETE`, estará nomeado com uma chave chamada `errors` em um formato de `JSON`. Exemplo:

```json
{
  "errors": { 
    "attribute1": ["message1", "message2"],
    "attribute2": ["message1"]
  }
}
```

## Endpoints

#### Caminho mais curto

  - **GET** http://localhost:3000/routes/shortest/:from/:to/:autonomy/:fuel_price  
  - curl http://localhost:3000/routes/shortest/a/e/10/2,5
  - **Response:**
  
  ```json
    {
      nodes: [
        "A",
        "B",
        "D"
      ],
      distance: 25,
      price: 6.25
    }
  ```

---

#### Mapa

**Lista de mapas**

  - **GET** http://localhost:3000/maps/  
  - curl http://localhost:3000/maps/
  - **Response:**
  
  ```json
    [{
      name: "SP"
    }, {
      name: "RJ"
    }, {
      name: "RS"
    }]
  ```

**Criar mapa**

  - **POST** http://localhost:3000/maps/  
  - curl -X POST --data "map[name]=foo" http://localhost:3000/maps/
  - **Response:** `{ "name": "FOO" }`

**Atualizar mapa**

  - **PUT** http://localhost:3000/maps/:id/  
  - curl -X PUT --data "map[name]=baz" http://localhost:3000/maps/1/
  - **Response:** `{ "name": "BAZ" }`

**Remover mapa**

  - **DELETE** http://localhost:3000/maps/:id/
  - curl -X DELETE http://localhost:3000/maps/1/
  - **Response:** `true|false` 

---

#### Cidade

**Lista de cidades**

  - **GET** http://localhost:3000/cities/  
  - curl http://localhost:3000/cities/
  - **Response:**
  
  ```json
    [
        {
          name: "A",
          routes: [
            { to: "B", distance: 10 },
            { to: "C", distance: 20 }
          ],
          map_name: "SP"
        }
    ]
  ```

**Lista de destinos**

  - **GET** http://localhost:3000/cities/destinations/ 
  - curl http://localhost:3000/cities/destinations/
  - **Response:**
  
  ```json
    {
      destinations: [
        ["A", "B", 10],
        ["A", "C", 20],
        ["B", "D", 15],
        ["B", "E", 50],
        ["C", "D", 30],
        ["D", "E", 30]
      ]
    }
  ```


**Criar cidade**

  - **POST** http://localhost:3000/cities/  
  - curl -X POST --data "city[name]=foo&city[routes][][to]=baz&city[routes][][distance]=12&city[map_name]=bar" http://localhost:3000/cities/
  - **Response:** 
  
  ```json
    {
      name: "A",
      routes: [
        { to: "B", distance: 10 },
        { to: "C", distance: 20 }
      ],
      map_name: "SP"
    }
  ```

**Atualizar cidade**

  - **PUT** http://localhost:3000/cities/:id/  
  - curl -X POST --data "city[name]=foo2&city[routes][][to]=baz&city[routes][][distance]=12&city[map_name]=bar" http://localhost:3000/cities/
  - **Response:** 

  ```json
    {
      name: "A",
      routes: [
        { to: "B", distance: 10 },
        { to: "C", distance: 20 }
      ],
      map_name: "SP"
    }
  ```

**Remover cidade**

  - **DELETE** http://localhost:3000/cities/:id/
  - curl -X DELETE http://localhost:3000/cities/1/
  - **Response:** `true|false` 