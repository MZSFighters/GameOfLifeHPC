#include <iostream>
#include <stdio.h>
#include <vector>
#include <string>

using namespace std;

void printGrid(bool* grid, int w, int h) {
    // cout << w << h;
    for (int i = 0; i < h; i++) {
        for (int j = 0; j < w; j++) {
            if (grid[i*w +j]) cout << "#";
            else cout << ".";
        }
        cout << endl;
    }
}


bool liveOrDie(bool* grid, int w, int h, int i, int j, int A, int B, int C){
    // get number of alive neighbours
    int sum = 0;
    int n, m;
    for (int k = -1; k <= 1; ++k) {
        for (int l = -1; l <= 1; ++l) {
            n = i + k;
            m = j + l;
            if (i==n && j==m) continue;
            n += h;
            m += w;
            sum += grid[(n%h)*w + m%w];
            // cout << i << " " << j;
            // printf("Here\n"); fflush(stdout);
        }
    }

    
    
    // decide whether cell should live or die
    bool live = grid[i*w + j];
    if (grid[i*w + j]) {
        if (sum > B || sum < A) live = false;
    } else {
        if (sum == C) live = true;
    }
    return live;
}

void updateGrid(bool* grid, bool* gridcpy, int w, int h, int A, int B, int C){
    for (int i = 0; i < h; i++) {
        for (int j = 0; j < w; j++) {
            bool judgement = liveOrDie(grid, w, h, i, j, A , B, C);
            gridcpy[i*w + j] = judgement;
        }
    }
}
    
    

    
int main() {
    // reading in grid ------------------//
    int w, h, n, m, A, B, C;
    string line;
    
    cin >> w >> h >> n >> m >> A >> B >> C;
    bool* grid = new bool[w*h];
    bool * gridcpy = new bool[w*h];

    // bool* grid = (bool *) malloc(w*h * sizeof(bool));
    // bool* gridcpy = (bool *) malloc(w*h * sizeof(bool));  
    
    cin.ignore();
    
    for(int i = 0; i < h; ++i){
        getline(cin, line);
        for (int j = 0; j < w; ++j) {
            char c = line[j];
            if(c == '#'){
                grid[i*w + j] = true;
            }
        }
    }
    
    // Updating Grid---------------------//
    for (int i = 0; i < n; i++) {
        
        updateGrid(grid, gridcpy, w, h, A, B, C);
        bool* temp = gridcpy;
        gridcpy = grid;
        grid = temp;
        if (!i%m) printGrid(grid, w, h);
    }

    if (n%m) printGrid(grid, w, h);

    // printGrid(grid, w, h);
    // cout << endl;
    // for (int i = 0; i < 3; i++) {
    //     updateGrid(grid, gridcpy, w, h, A, B, C);
    // } 
    //----------------------------------//

    // free memory 
    delete(grid);
    delete(gridcpy);

    return 0;
}
