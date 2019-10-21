import xml.etree.ElementTree as ET
from quik import FileLoader

def gen():
    xmlTree = ET.parse('../hardwareEngine/hw_conf.xml')
    root = xmlTree.getroot()
    
    number_of_node = int(root[1][0].text) * int(root[1][1].text)

    xmlTree = ET.parse('mapping.xml')
    root = xmlTree.getroot()
    
    # create a dictionary of list from mapping xml file
    mapping_dict = {}
    for element in root:
        if element.tag == 'process_mapping':
            mapping_dict[element.get('name')] = [element.get('target'), element.get('cpuName')]
                
    xmlTree = ET.parse('application.xml')
    root = xmlTree.getroot()

    node_arr = {}
    sw_scripts = []
    for element in root:
        if element.tag == 'process':
            proc_name = element.get('name')
            for subelement in element:
                if subelement.tag == 'source_file':
                    src_name = subelement.get('name')
                    node_arr[mapping_dict[proc_name][0]] = [proc_name, src_name + '.c']

    for nodes in node_arr:
        sw_scripts.clear()
        sw_scripts.append({'nodeName': nodes,
                          'sourceFileName': node_arr[nodes][1],
                          'cpuName': mapping_dict[node_arr[nodes][0]][1] + '2' + '_' + mapping_dict[node_arr[nodes][0]][0].split('_')[1] })

        loader = FileLoader('')
        template = loader.load_template('sw_script_template.sh')

        with open('../../sw_scripts/create_'+mapping_dict[node_arr[nodes][0]][0]+'.sh', 'w', encoding='utf-8') as f:
            f.write(template.render(locals()))
