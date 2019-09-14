import xml.etree.ElementTree as ET
from quik import FileLoader

def gen():
    xmlTree = ET.parse('mapping.xml')
    root = xmlTree.getroot()
    
    # create a dictionary of list from mapping xml file
    mapping_dict = {}
    for element in root:
        if element.tag == 'process_mapping':
            mapping_dict[element.get('name')] = [element.get('target'), element.get('cpuName')]
    
    xmlTree = ET.parse('application.xml')
    root = xmlTree.getroot()

    sw_scripts = []
    for element in root:
        if element.tag == 'process':
            proc_name = element.get('name')
            for subelement in element:
                if subelement.tag == 'source_file':
                    src_name = subelement.get('name')
                    sw_scripts.clear()
                    sw_scripts.append({'nodeName': mapping_dict[proc_name][0],
                                      'sourceFileName': src_name + '.c',
                                      'cpuName': mapping_dict[proc_name][1] + '2' + '_' +  mapping_dict[proc_name][0].split('_')[1] })

                    loader = FileLoader('')
                    template = loader.load_template('sw_script_template.sh')

                    with open('../../sw_scripts/create_'+mapping_dict[proc_name][0]+'.sh', 'w', encoding='utf-8') as f:
                        f.write(template.render(locals()))

