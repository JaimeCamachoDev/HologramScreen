
using UnityEngine;
using UnityEditor;

public class MaxKillStudios_SciFiHoloScreenShaderGUI : ShaderGUI
{
    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
    {
        Material targetMat = materialEditor.target as Material;
        string shaderName = targetMat.shader.name;

        EditorGUILayout.Space(5);

        EditorGUILayout.BeginHorizontal();

        GUIStyle titleStyle = new GUIStyle(EditorStyles.boldLabel);
        titleStyle.fontSize = 16;
        GUILayout.Label("Sci-Fi Hologram Screen Shader", titleStyle);

        GUILayout.Space(10);

        if (GUILayout.Button("Open Documentation", GUILayout.Height(22), GUILayout.Width(140)))
        {
            Application.OpenURL("https://www.maxkillstudios.com/unity/scifi-hologram-screen-shader");
        }

        GUILayout.FlexibleSpace();
        EditorGUILayout.EndHorizontal();

        EditorGUILayout.Space(5);

        EditorGUILayout.BeginHorizontal();

        string shaderDisplayName = shaderName;
        if (shaderName.Contains("/"))
        {
            shaderDisplayName = shaderName.Substring(shaderName.LastIndexOf("/") + 1);
        }

        string variantName = "";
        if (shaderDisplayName.Contains("Additive"))
        {
            variantName = "SciFiHoloScreen Additive";
        }
        else
        {
            variantName = "SciFiHoloScreen";
        }

        string pipelineName = "BuiltIn";
        Color pipelineColor = new Color(0.2f, 0.5f, 0.8f);

        if (shaderDisplayName.Contains("URP") || shaderName.Contains("Universal"))
        {
            pipelineName = "URP";
            pipelineColor = new Color(0.2f, 0.7f, 0.3f);
        }
        else if (shaderDisplayName.Contains("HDRP") || shaderName.Contains("HDRP"))
        {
            pipelineName = "HDRP";
            pipelineColor = new Color(0.8f, 0.3f, 0.2f);
        }

        GUIStyle variantStyle = new GUIStyle(GUI.skin.box);
        variantStyle.fontSize = 12;
        variantStyle.fontStyle = FontStyle.Bold;
        variantStyle.alignment = TextAnchor.MiddleCenter;
        variantStyle.padding = new RectOffset(10, 10, 3, 3);
        variantStyle.normal.textColor = EditorGUIUtility.isProSkin ? Color.white : Color.black;

        Texture2D variantBg = new Texture2D(1, 1);
        variantBg.SetPixel(0, 0, EditorGUIUtility.isProSkin ? new Color(0.3f, 0.3f, 0.3f) : new Color(0.8f, 0.8f, 0.8f));
        variantBg.Apply();
        variantStyle.normal.background = variantBg;

        GUILayout.Label(variantName, variantStyle, GUILayout.Height(22));

        GUILayout.Space(5);

        GUIStyle tagStyle = new GUIStyle(GUI.skin.box);
        tagStyle.fontSize = 12;
        tagStyle.fontStyle = FontStyle.Bold;
        tagStyle.alignment = TextAnchor.MiddleCenter;
        tagStyle.padding = new RectOffset(10, 10, 3, 3);
        tagStyle.normal.textColor = Color.white;

        Texture2D tagBg = new Texture2D(1, 1);
        tagBg.SetPixel(0, 0, pipelineColor);
        tagBg.Apply();
        tagStyle.normal.background = tagBg;

        GUILayout.Label(pipelineName, tagStyle, GUILayout.Height(22));

        GUILayout.FlexibleSpace();
        EditorGUILayout.EndHorizontal();

        EditorGUILayout.Space(10);

        string lastHeader = "";

        foreach (MaterialProperty prop in props)
        {
            if ((prop.propertyFlags & UnityEngine.Rendering.ShaderPropertyFlags.HideInInspector) != 0)
                continue;

            string currentHeader = FindHeaderForProperty(prop.name);

            if (!string.IsNullOrEmpty(currentHeader) && currentHeader != lastHeader)
            {
                EditorGUILayout.Space(8);

                Rect headerRect = GUILayoutUtility.GetRect(0, 28, GUILayout.ExpandWidth(true));

                Color bgColor = EditorGUIUtility.isProSkin
                    ? new Color(0.18f, 0.18f, 0.18f)
                    : new Color(0.9f, 0.9f, 0.9f);

                EditorGUI.DrawRect(headerRect, bgColor);

                GUIStyle localHeaderStyle = new GUIStyle(GUI.skin.label)
                {
                    alignment = TextAnchor.MiddleLeft,
                    fontSize = 15,
                    fontStyle = FontStyle.Bold,
                    padding = new RectOffset(10, 0, 0, 0)
                };
                localHeaderStyle.normal.textColor = EditorGUIUtility.isProSkin ? Color.white : Color.black;
                localHeaderStyle.hover.textColor = localHeaderStyle.normal.textColor;
                localHeaderStyle.active.textColor = localHeaderStyle.normal.textColor;

                GUI.Label(headerRect, currentHeader, localHeaderStyle);

                EditorGUILayout.Space(4);
                lastHeader = currentHeader;
            }

            materialEditor.ShaderProperty(prop, prop.displayName);
        }

        materialEditor.LightmapEmissionProperty();

        EditorGUILayout.Space();
    }

    private string FindHeaderForProperty(string propName)
    {
        if (propName.Contains("Frame")) return "Frame";
        if (propName.Contains("Hologram") && !propName.Contains("Random")) return "Hologram";
        if (propName.Contains("RChannel")) return "Red Channel";
        if (propName.Contains("GChannel")) return "Green Channel";
        if (propName.Contains("BChannel")) return "Blue Channel";
        if (propName.Contains("AlphaChannel")) return "Alpha Channel";
        if (propName.Contains("BackdropFog")) return "Backdrop Fog";
        if (propName.Contains("Backdrop")) return "Backdrop";
        if (propName.Contains("SpriteSheet") || propName.Contains("Rows") || propName.Contains("Columns")) return "SpriteSheet Mode";

        return "";
    }
}
