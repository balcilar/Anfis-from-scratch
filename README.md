# Adaptive Neuro Fuzzy Inference System (ANFIS) from scratch

This repository consists of the full source code of Adaptive neuro-fuzzy inference system from scratch. The method originally described in [1]. It does not depend on Matlab toolbox. every single detail was coded in Matlab. You can compare our result by Matlab toolbox's equivalent results. 

# Theory

According to ANFIS theory it has 5 layer excluded input layer as it shown by following figure [1]. Given figure is just an example for 2 input dimension x and y. both inputs have 3 fuzzy set named A1,A2,A3 for x input, B1,B2,B3 fuzzy set for y input. Let us suppose we have *N* number of inputs and *M* number of fuzzy set to represent each inputs. That means we will have *NxM* number of node in Layer1. In Layer2, all nodes have to connection from a membership function output of each input node which means we will have *M^N* node in Layer2. In layer 3 and 4, there are the same number of node with Layer2. Layer 5 has just one node which represent the output of the network. If we assume the inputs as a node then all nodes in given architecture becomes *N + NxM + 3xM^N + 1*.
![Sample image](Output/anfis.jpg?raw=true "Title")
Although the ANFIS network is quite large and has too many connection for high number of fuzzy set and input variable, most of the parameters are not trainable, only a few of the is trainable which means ANFIS's degree of freedom is quite low according to aquivalent Artificial Neural Network (ANN) architectures. In Anfis architecture, just membership functions parameters in Layer1 and inputs weight in Layer 4 are to be estimated by traning algorithm. that means in our example case, if we use Generalized bell-shaped membership function (gbellmf) which is described by 3 parameters, we need to estimate *3xMxN* premise parameters in Layer1 and *NxM^N* consequent weight parameters in Layer4. 

# Results

We provided two different demos. The first one for 216 elements, 3 input, 1 output data. We used 2 fuzzy sets for each input variable which means N=3 and M=2. In that configuration, the network has total 34 nodes. Here is the nodes and its connections map. Connected nodes are shown by yellow color.

![Sample image](Output/connection.jpg?raw=true "Title")

After training network, the estimated premise parameter are shown by following figure. Since we have 3 inputs and each input modelled with 2 different fuzzy set, we have 3 plot and each plot has 2 membership function.

![Sample image](Output/memberships.jpg?raw=true "Title")

To show the estimated paramters, you can check mparams variable for premise parameter or kparams variable for consequent parameters of the trained network object named bestnet.

```
>> bestnet.mparams

ans =

    0.3161    0.5914   -0.1318
    1.2933    0.6453    6.1674
    0.2330    0.7558   -0.0393
    1.3592    0.3542    6.2053
    0.1619    1.0083    0.1323
    1.3913    0.5173    6.1012

>> bestnet.kparams

ans =

   25.6053   10.4837   34.9184   49.7327
    3.2049  -11.1786    0.0302   20.0289
    4.3492    0.3341    1.2617   25.2821
    1.7483   -0.3359   -0.0201    4.9561
    8.9303  -12.6436   45.8124   46.3622
    2.7314  -14.4454   -0.0334   30.3140
    3.8722   -0.4706   22.2196   28.2463
    1.4949   -0.4744   -0.0152    7.9351
    
```

Finally you can find the results of Demo1.m script.

![Sample image](Output/demo1.jpg?raw=true "Title")

In demo2, we used 4 fuzzy set for representing the inputs. Here is the results of Demo2.m script.

![Sample image](Output/demo2.jpg?raw=true "Title")

In all two demos, we used 100 number of iterations. Since the provided projects does not support any other membership function, we necessarily used Generalized bell-shaped membership function (gbellmf) which is described by 3 parameters.

# Reference
[1] Jang, J-SR. "ANFIS: adaptive-network-based fuzzy inference system." IEEE transactions on systems, man, and cybernetics 23.3 (1993): 665-685.
