package configuration.commads
{
	import configuration.Config;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import org.br.behavior.commands.Command;
	
	import utils.AppConstants;
	
	/**
	 * This command will load a xml with config, case don't exist will create a template. 
	 * @author maurício césar
	 * 
	 */
	public class CommandLoadConfiguration extends Command
	{
		private var xml:String = "/data.xml";
		
		/**
		 * Class Constructor 
		 */
		public function CommandLoadConfiguration()
		{
			super();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function execute(scope:Object):void{
			super.execute(scope);
			
			createSystemBaseFolder();
			getXmlConfigurationFile();
		}
		
		/**
		 * @private 
		 */
		private function createSystemBaseFolder():void{
			var directory:File = new File(File.documentsDirectory.resolvePath(AppConstants.APP_PATCH).url);
			
			if(!directory.exists){
				directory.createDirectory();
			}
		}
		
		/**
		 * @private
		 */
		private function getXmlConfigurationFile():void{
			
 			var xmlFile:File = File.documentsDirectory.resolvePath(AppConstants.APP_PATCH+xml);
			
			var fileStream:FileStream 
			
			if(!xmlFile.exists){
				fileStream = new FileStream();
				
				fileStream.open(xmlFile , FileMode.WRITE);
				
				fileStream.writeUTFBytes(defaultData);
				fileStream.close();
				
			}
			
			fileStream = new FileStream();
			fileStream.open(xmlFile, FileMode.READ);
			(shell as Config).xmlConfig = new XML(fileStream.readUTFBytes(fileStream.bytesAvailable)); 
			fileStream.close();
			
			sucess();
		}
		
		/**
		 * GET the default data with application presentation;
		 * @return 
		 */
		private function get defaultData():String{
			var result:String;
			
			//copy default images and text sources to current directory;
			
			//generate xml content
			result = '<?xml version="1.0" encoding="utf-8" standalone="no"?>\n';
			
			result += '<application>\n';
			//generate video options
			
			result += '	<!-- Estabelece parâmetros para exibição -->\n';
			result += '	<video>\n';
			result += '		<!-- Determina o monitor de exibição da aplicação - no caso de 1 monitor apenas usar o número 0, caso contrário descobrir o número do monitor -->\n';
			result += '		<display>1</display>\n';
			result += '		<!-- Determina a área máxima de exibição, no tamanho real (menor zoom), para ajuste às medidas do monitor de exibição -->\n';
			result += '		<pageScreemWidth>0</pageScreemWidth>\n';
			result += '		<pageScreemHeight>0</pageScreemHeight>\n';
			result += '		<!-- Determina a área máxima da arte para calculo de zoom  e para ajuste às medidas do monitor de exibição -->\n';
			result += '		<pageWidth>0</pageWidth>\n';
			result += '		<pageHeight>0</pageHeight>\n';
			result += '		<!-- Determina a referência do eixo O da construção de páginas - page: ponto zero através das medidas da página - pageScreem : ponto zero através das medidas da pageScreem (área de xibição da página)  -->\n';
			result += '		<zeroAchorReference>0</zeroAchorReference>\n';
			result += '	</video>\n';
			
			result += '	<!-- Estabelece parâmetros para o kinect (apenas quando a aplicação reconhecer um kinect) -->\n';
			result += '	<kinect>\n';
			result += '		<!-- define a altura de instalação do kinect -->\n';
			result += '		<verticalPosition>1.5</verticalPosition>\n';
			result += '		<!-- define a ára horizontal máxima para interação com o kinect -->\n';
			result += '		<interactionArea>1500</interactionArea>\n';
			result += '		<!-- define a distância máxima para interação com o kinect (mm)-->\n';
			result += '		<interactionDistance>3000</interactionDistance>\n';
			result += '		<!-- define se o usuário poderá intgeragir com zoom -->\n';
			result += '		<useZoom>true</useZoom>\n';
			
			result += '		<interactions>'
			result += '			<!-- Página exibida na ausência de usuário detectado  -->\n';
			result += '			<page type="noUser">\n';
			
			result += '				<asset type="graphic">\n';
			result += '					<source>fundotela.jpg</source>\n';
			result += '					<posX>10</posX>\n';
			result += '					<posY>10</posY>\n';
			result += '					<gain>10</gain>\n';
			result += '					<distance>50</distance>\n';
			result += '					<scale>0</scale>\n';
			result += '				</asset>\n';
			
			result += '				<asset type="media">\n';
			result += '					<source>uphe03downhe05.png</source>\n';
			result += '					<posX>10</posX>\n';
			result += '					<posY>10</posY>\n';
			result += '					<gain>10</gain>\n';
			result += '					<distance>50</distance>\n';
			result += '					<scale>0</scale>\n';
			result += '				</asset>\n';
			
			result += '			</page>\n';
			
			result += '			<!-- Primeiro passo após a detecção de um usuário - Informa o usuário sobre as formas de interação e termina com gesture de slide   -->\n';
			result += '			<page type="userHowTo">\n';
			
			result += '				<asset type="graphic">\n';
			result += '					<source>fundotela.jpg</source>\n';
			result += '					<posX>10</posX>\n';
			result += '					<posY>10</posY>\n';
			result += '					<gain>10</gain>\n';
			result += '					<distance>50</distance>\n';
			result += '					<scale>0</scale>\n';
			result += '				</asset>\n';
			
			result += '				<asset type="media">\n';
			result += '					<source>uphe03downhe05.png</source>\n';
			result += '					<posX>10</posX>\n';
			result += '					<posY>10</posY>\n';
			result += '					<gain>10</gain>\n';
			result += '					<distance>50</distance>\n';
			result += '					<scale>0</scale>\n';
			result += '				</asset>\n';
			
			result += '				<asset type="userVideo">\n';
			result += '					<source>uphe03downhe05.png</source>\n';
			result += '					<posX>10</posX>\n';
			result += '					<posY>10</posY>\n';
			result += '					<gain>10</gain>\n';
			result += '					<distance>50</distance>\n';
			result += '					<scale>0</scale>\n';
			result += '				</asset>\n';
			
			result += '				<asset type="userImage">\n';
			result += '					<source>uphe03downhe05.png</source>\n';
			result += '					<posX>10</posX>\n';
			result += '					<posY>10</posY>\n';
			result += '					<gain>10</gain>\n';
			result += '					<distance>50</distance>\n';
			result += '					<scale>0</scale>\n';
			result += '				</asset>\n';
			
			result += '			</page>\n';
			
			result += '			<!-- Após inicio da aplicação e tempo sem interação exibe mensagem de como finalizar a interação, afastando-se   -->\n';
			result += '			<page type="userHowEndInteraction">\n';
			
			result += '				<asset type="graphic">\n';
			result += '					<source>fundotela.jpg</source>\n';
			result += '					<posX>10</posX>\n';
			result += '					<posY>10</posY>\n';
			result += '					<gain>10</gain>\n';
			result += '					<distance>50</distance>\n';
			result += '					<scale>0</scale>\n';
			result += '				</asset>\n';
			
			result += '			</page>\n';
			
			result += '		</interactions>\n'
			
			result += '		<!-- Organiza os assets defaults que são usados com o kinect -->\n';
			result += '		<icons>\n'
			
			result += '			<!-- Icone para gesture de uma mão em movimento (mover conteúdo da página) -->\n';
			result += '			<asset type="handInteraction">\n';
			result += '				<source>fundotela.jpg</source>\n';
			result += '				<posX>10</posX>\n';
			result += '				<posY>10</posY>\n';
			result += '				<gain>10</gain>\n';
			result += '				<distance>50</distance>\n';
			result += '				<scale>0</scale>\n';
			result += '			</asset>\n';
			
			result += '			<!-- Icone para gesture de duas mãos em movimento (controle de zoom no conteúdo da página)  -->\n';
			result += '			<asset type="2handsInteraction">\n';
			result += '				<source>fundotela.jpg</source>\n';
			result += '				<posX>10</posX>\n';
			result += '				<posY>10</posY>\n';
			result += '				<gain>10</gain>\n';
			result += '				<distance>50</distance>\n';
			result += '				<scale>0</scale>\n';
			result += '			</asset>\n';
			
			result += '			<!-- Icone para gesture de movimento de uma mão com velocida de um lado para o outro (troca a página)  -->\n';
			result += '			<asset type="slideInteraction">\n';
			result += '				<source>fundotela.jpg</source>\n';
			result += '				<posX>10</posX>\n';
			result += '				<posY>10</posY>\n';
			result += '				<gain>10</gain>\n';
			result += '				<distance>50</distance>\n';
			result += '				<scale>0</scale>\n';
			result += '			</asset>\n';
			
			result += '			<!-- Icone para informar como finalizar a interação (o usuário deve mover-se para longe da ára de interação)  -->\n';
			result += '			<asset type="stopInteraction">\n';
			result += '				<source>fundotela.jpg</source>\n';
			result += '				<posX>10</posX>\n';
			result += '				<posY>10</posY>\n';
			result += '				<gain>10</gain>\n';
			result += '				<distance>50</distance>\n';
			result += '				<scale>0</scale>\n';
			result += '			</asset>\n';
			
			result += '		</icons>\n'
			
			result += '	</kinect>\n';
			
			result += '	<promotions id="promo1" >\n';
			result += '		<pausedTime>6000</pausedTime>\n';
			result += '		<transitionTime>1500</transitionTime>\n';
			result += '		<assetDefault>logo.png</assetDefault>\n';
			result += '		<assetDefault>uphe03downhe05.png</assetDefault>\n';
			
			result += '		<page type="Test Título">\n';
				
			result += '			<asset type="graphic">\n';
			result += '				<source>fundotela.jpg</source>\n';
			result += '				<posX>10</posX>\n';
			result += '				<posY>10</posY>\n';
			result += '				<gain>10</gain>\n';
			result += '				<distance>50</distance>\n';
			result += '				<scale>0</scale>\n';
			result += '			</asset>\n';

			result += '			<asset type="media">\n';
			result += '				<source>uphe03downhe05.png</source>\n';
			result += '				<posX>10</posX>\n';
			result += '				<posY>10</posY>\n';
			result += '				<gain>10</gain>\n';
			result += '				<distance>50</distance>\n';
			result += '				<scale>0</scale>\n';
			result += '			</asset>\n';

			result += '			<asset type="graphic">\n';
			result += '				<source>upshe01downshe03.png</source>\n';
			result += '				<posX>10</posX>\n';
			result += '				<posY>10</posY>\n';
			result += '				<gain>10</gain>\n';
			result += '				<distance>50</distance>\n';
			result += '				<scale>0</scale>\n';
			result += '			</asset>\n';

			result += '		</page>\n';
			
			
			result += '	</promotions>\n';
			
						
			result += '</application>';
			return result;
		}
	}
}