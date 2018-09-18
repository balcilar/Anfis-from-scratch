# Adaptive Neuro Fuzzy Inference System (ANFIS) from scratch

This repository consists of the full source code of Adaptive neuro-fuzzy inference system from scratch. The method originally described in [1]. It does not depend on Matlab toolbox. every single detail was coded in Matlab. You can compare our result by Matlab toolbox's equivalent results. 

According to ANFIS theory it has 5 layer excluded input layer as it shown by following figure [1].

![Sample image](Output/anfis.jpg?raw=true "Title")





We also provided two different demos. The first one for 216 elements, 3 input, 1 output data. The second demo is for 121 elements, 2 inputs, 1 output data.

In demo1, we used 2 fuzzy set for representing the inputs. Here is the results of Demo1.m script.

![Sample image](Output/demo1.jpg?raw=true "Title")

In demo2, we used 4 fuzzy set for representing the inputs. Here is the results of Demo2.m script.

![Sample image](Output/demo2.jpg?raw=true "Title")

In all two demos, we used 100 number of iterations. Since the provided projects does not support any other membership function, we necessarily used Generalized bell-shaped membership function (gbellmf) which is described by 3 parameters.

# Reference
[1] Jang, J-SR. "ANFIS: adaptive-network-based fuzzy inference system." IEEE transactions on systems, man, and cybernetics 23.3 (1993): 665-685.
