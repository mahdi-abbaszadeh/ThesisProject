import xml.etree.ElementTree as ET
from quik import FileLoader

def gen():
    xmlTree = ET.parse('../hardwareEngine/hw_conf.xml')
    root = xmlTree.getroot()

    number_of_node = int(root[1][0].text) * int(root[1][1].text)

    xmlTree = ET.parse('application.xml')
    root = xmlTree.getroot()

    processes = []

    for element in root:
        if element.tag == 'process':
            temp = {}
            temp['process_name'] = element.get('name')
            temp['numOfInp'] = element.get('numOfInp')
            temp['numOfOut'] = element.get('numOfOut')
            for subElement in element:
                temp2 = {}
                if subElement.tag == 'port':
                    temp2['ID'] = subElement.get('ID')
                    temp2['name'] = subElement.get('name')
                    temp2['type'] = subElement.get('type')
                    temp2['direction'] = subElement.get('direction')
                    temp2['numOfToken'] = subElement.get('numOfToken')
                    temp.update({subElement.get('name'): temp2})
                elif subElement.tag == 'source_file':
                    temp.update({'source_file': subElement.get('name').split('_')[1]})
            processes.append(temp)

    i = 0
    edges = []
    for i in range(number_of_node):




        loader = FileLoader('')
        template = loader.load_template('Templates/packet_transaction_util_template.c')
        with open('../../packet_transaction_lib/src/src'+str(i)+'packet_transaction_util.c', 'w', encoding='utf-8') as f:
            f.write(template.render(locals()))