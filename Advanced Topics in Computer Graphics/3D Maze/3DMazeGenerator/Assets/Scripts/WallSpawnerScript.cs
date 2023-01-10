using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WallSpawnerScript : MonoBehaviour
{
    public GameObject cubePrefab;
    public GameObject wallPrefab;
    public GameObject pathPrefab;

    public int maxDepth = 5;
    int depth = 0;
    float mazeWidth = 5f;
    public float loopChance = 0.0f;
    public float width = 10f;
    int count = 0;
    int iterations = 0;

    public static List<Vector3> visitedNeighbours = new List<Vector3>();
    public static List<Vector3> paths = new List<Vector3>();

    void Start(){
        Vector3 vec = new Vector3(0f,0f,0f);
        maze(vec);
        placeWalls();
    }

    public void placeWallHorizontal(Vector3 wallPosition)
    {
        Instantiate(wallPrefab, wallPosition, Quaternion.identity);
    }
    public void placeWallVecrtical(Vector3 wallPosition)
    {
        Instantiate(wallPrefab, wallPosition, Quaternion.Euler(0, 90, 0));
    }
    public void placePath(Vector3 wallPosition)
    {
        Instantiate(pathPrefab, wallPosition, Quaternion.Euler(0, 0, 0));
    }

    public void maze(Vector3 vec)
    {
        addToVisistedNeighbours(vec);
        while(true){
            iterations++;
            List<Vector3> neighboursList = avaiableNeighbours(vec);
            if(neighboursList.Count > 0 && depth < maxDepth){
                depth++;
                int rannum = Random.Range(0, neighboursList.Count);
                Vector3 pick = neighboursList[rannum];
                addWall(vec, pick);
                maze(pick);
            }else if(done()){
                depth = 0;
                return;
            }else{
                depth = 0;
                int rannum =  Random.Range(0, visitedNeighbours.Count);
                Vector3 pick = visitedNeighbours[rannum];
                maze(pick);
            }
        }
    }

    public void placeWalls()
    {
        int rndStart = Mathf.RoundToInt(Random.Range(0, width/mazeWidth))*Mathf.RoundToInt(mazeWidth);
        int rndFinish = Mathf.RoundToInt(Random.Range(0, width/mazeWidth))*Mathf.RoundToInt(mazeWidth);
        print("finish is: " + rndFinish);
        for(float i = 0f; i <= width; i +=mazeWidth){
            for(float j = 0f; j <= width; j +=mazeWidth){
            if(contains(new Vector3(i+mazeWidth/2,1f,j), paths) == false){
                if((i == width) && (j == rndFinish)){
                    continue;
                }
                placeWallHorizontal(new Vector3(i+mazeWidth,1f,j));
            }
            if(contains(new Vector3(i,1f,j+mazeWidth/2), paths) == false){
                placeWallVecrtical(new Vector3(i+mazeWidth/2,1f,j+mazeWidth/2));
            }
            }
        }
        for(float i = 0f; i <= width; i +=mazeWidth){
            if(i !=rndStart){
                placeWallHorizontal(new Vector3(0f,1f,i));
            }
            placeWallVecrtical(new Vector3(i+mazeWidth/2,1f,-mazeWidth/2));
        }
    }

    public List<Vector3> avaiableNeighbours(Vector3 vec){
        List<Vector3> neighbours = new List<Vector3>();

        Vector3 above = vec + new Vector3(0,0,-mazeWidth);
        Vector3 below = vec + new Vector3(0,0,mazeWidth);
        Vector3 left = vec + new Vector3(-mazeWidth,0,0);
        Vector3 right = vec + new Vector3(mazeWidth,0,0);
        if(Random.Range(0,100) < loopChance){
            if(notOutOfBounce(above)){neighbours.Add(above);}
            if(notOutOfBounce(below)){neighbours.Add(below);}
            if(notOutOfBounce(left)){neighbours.Add(left);}
            if(notOutOfBounce(right)){neighbours.Add(right);}
        }else{
        if(notOutOfBounce(above) && !contains(above, visitedNeighbours)){
            neighbours.Add(above);
        }
        if(notOutOfBounce(below) && !contains(below, visitedNeighbours)){
            neighbours.Add(below);
        }
        if(notOutOfBounce(left) && !contains(left, visitedNeighbours)){
            neighbours.Add(left);
        }
        if(notOutOfBounce(right) && !contains(right, visitedNeighbours)){
            neighbours.Add(right);
        }
        }
        return neighbours;
    }

    public bool done()
    {
        return visitedNeighbours.Count >= Mathf.Pow(width/mazeWidth,2);
    }
    
    public void addToVisistedNeighbours(Vector3 vec){
        if(contains(vec, visitedNeighbours) == false){
            visitedNeighbours.Add(vec);
        }
    }

    public void addWall(Vector3 origin, Vector3 direction)
    {
        paths.Add(new Vector3((origin.x+direction.x)/2f,1f,(origin.z+direction.z)/2f));
    }

    public bool notOutOfBounce(Vector3 vec){
        if((vec.x <= width) && (vec.z <= width) && (vec.z >= 0) && (vec.x >= 0)){
            return true;
        }
        return false;
    }

    public bool contains(Vector3 vec, List<Vector3> array) {
    int i = array.Count;
    while (i>0) {
        i--;
        if (array[i].x == vec.x && array[i].z == vec.z ) {
            return true;
        }
    }
    return false;
}
}