using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Code from https://www.youtube.com/watch?v=f473C43s8nE&t=434s

public class MoveCamera : MonoBehaviour
{
    public Transform cameraPosition;

    // Update is called once per frame
    private void Update()
    {
        transform.position = cameraPosition.position;
    }
}
