(function(){var fileNsPrefix=function(){"use strict";var scripts=document.getElementsByTagName("script");var lastScript=scripts[scripts.length-1];var scriptName=lastScript.src;var parts=scriptName.split("/");var partsLength=parts.length-1;var thisScript=parts[partsLength--];if(thisScript===""){thisScript=parts[partsLength--]}if(scriptName.indexOf("__")!=-1){while(thisScript.indexOf("__")==-1&&partsLength>=0){thisScript=parts[partsLength];partsLength--}}var lowerCasePrefix=thisScript.indexOf("__")==-1?"":thisScript.substring(0,thisScript.indexOf("__")+2);lowerCasePrefix=lowerCasePrefix===""&&localStorage.getItem("nsPrefix")?localStorage.getItem("nsPrefix"):lowerCasePrefix;if(lowerCasePrefix!==""){lowerCasePrefix=/__$/.test(lowerCasePrefix)?lowerCasePrefix:lowerCasePrefix+"__"}if(lowerCasePrefix.length===0){return function(){lowerCasePrefix=window.nsPrefix?window.nsPrefix:lowerCasePrefix;if(lowerCasePrefix!==""){lowerCasePrefix=/__$/.test(lowerCasePrefix)?lowerCasePrefix:lowerCasePrefix+"__"}return lowerCasePrefix}}else{var resolvedNs=null;return function(){if(resolvedNs){return resolvedNs}try{var tofind=lowerCasePrefix.replace("__","");var name;var scanObjectForNs=function(object,alreadySeen){if(object&&object!==window&&alreadySeen.indexOf(object)==-1){alreadySeen.push(object);Object.keys(object).forEach(function(key){if(key==="ns"){if(typeof object[key]==="string"&&object[key].toLowerCase()===tofind){name=object[key]+"__";return false}}if(Object.prototype.toString.call(object[key])==="[object Array]"){object[key].forEach(function(value){var result=scanObjectForNs(value,alreadySeen);if(result){name=result;return false}})}else if(typeof object[key]=="object"){var result=scanObjectForNs(object[key],alreadySeen);if(result){name=result;return false}}if(name){return false}});if(name){return name}}};if(typeof Visualforce!=="undefined"){scanObjectForNs(Visualforce.remoting.Manager.providers,[])}else{return lowerCasePrefix}if(name){return resolvedNs=name}else{return resolvedNs=lowerCasePrefix}}catch(e){return lowerCasePrefix}}}}();var fileNsPrefixDot=function(){var prefix=fileNsPrefix();if(prefix.length>1){return prefix.replace("__",".")}else{return prefix}};
(function(){function r(e,n,t){function o(i,f){if(!n[i]){if(!e[i]){var c="function"==typeof require&&require;if(!f&&c)return c(i,!0);if(u)return u(i,!0);var a=new Error("Cannot find module '"+i+"'");throw a.code="MODULE_NOT_FOUND",a}var p=n[i]={exports:{}};e[i][0].call(p.exports,function(r){var n=e[i][1][r];return o(n||r)},p,p.exports,r,e,n,t)}return n[i].exports}for(var u="function"==typeof require&&require,i=0;i<t.length;i++)o(t[i]);return o}return r})()({1:[function(require,module,exports){
var module = angular.module('vloc.xomNodeView', ['vlocity', 'mgcrea.ngStrap',  'ngSanitize']);

module.config(['remoteActionsProvider', function(remoteActionsProvider) {
    remoteActionsProvider.setRemoteActions(window.remoteActions || {});
}]);

//changed the name of module from camel case vloc.xomNodeView since grunt is not detecting the module while injecting the dependency and needs to have the same module name as present in the folder structure
// require('./modules/xomnodeview/directive/NGIncludeTemplate.js');
require('./modules/xomnodeview/directive/XOMNodeViewDirective.js');
require('./modules/xomnodeview/filter/linenumber.js');
require('./modules/xomnodeview/templates/templates.js');

},{"./modules/xomnodeview/directive/XOMNodeViewDirective.js":2,"./modules/xomnodeview/filter/linenumber.js":3,"./modules/xomnodeview/templates/templates.js":4}],2:[function(require,module,exports){
angular.module('vloc.xomNodeView').directive('nodeView', ['$compile', 'remoteActions', function($compile, remoteActions) {

    return {

        templateUrl: 'NodeView.tpl.html',

        scope: {
            parent: '=',
            orders: '=',
            frs: '='
        },
        // replace: true,
        restrict: 'E',
        controller:  ['$scope', function($scope) {
        	
        	$scope.getTooltip = function (message, helperArg) {
        		if (helperArg === 'processAtrribute'){
        			message = $scope.processAtrribute(message);	
        		}
        		else if (helperArg != '' && helperArg != null){
        			message = message | helperArg;
        		}
        		return {title:message};
        	};
        	$scope.getRichTooltip = function(attr, helperArg, node){
        		var sourceOiAttrNodeId, val;
        		if (helperArg === 'processAtrribute'){
        			message = $scope.processAtrribute(message);	
        		}
        		else if (helperArg != '' && helperArg != null){
        			message = message | helperArg;
        		}
        		if(node.type=='Fulfilment Request Line')
        		{
        			if(node.attrMappings!=null && node.attrMappings['attr_'+node.specId+'_'+attr.name]!=null){
        				val = node.attrMappings['attr_'+node.specId+'_'+attr.name];
        				message = val!=null?message+'Source-Attribute:&nbsp;  '+val.mappingObj['source_attr_name']+'<br/>Mapping type: '+val.mappingObj['mapping_type']:message;
        			}
        			else if(node.fieldMappings!=null && node.fieldMappings['attr_'+node.specId+'_'+attr.name]!=null){
        				val = node.fieldMappings['attr_'+node.specId+'_'+attr.name];
        				message = val!=null?message+'Source-Field:  '+val.mappingObj['source_field_name']+'<br/>Mapping type: '+val.mappingObj['mapping_type']:message;
        			}
        			else if(node.staticMappings!=null){
        				val = node.staticMappings['attr_'+node.specId+'_'+attr.name];
        				message = val!=null?message+'Static Value:  '+val.mappingObj.value+'<br/>Mapping type: static':message;
        			}
        			else {
        				message = message+'Default Value';
        			}
        			if(val!=null){
        				message = message+'<br/>Source-OrderItem:  '+val.srcOrderItemName+'  ('+val.srcOrderItemId+')';
        			}
        		}
        		return {title:message};
        	};
        	$scope.togglePanel = function(node){
        		node.isPanelExpanded = !(node.isPanelExpanded);
        	}

            $scope.isNodeActive = function (activeNodes, nodeIdx) {

                // console.log ('isNodeActive', $scope, nodeIdx);
                function isNumeric(n) {
                    return !isNaN(parseFloat(n)) && isFinite(n);
                }

                if (isNumeric(activeNodes)) {
                    return activeNodes == nodeIdx;
                } else {
                    return activeNodes.indexOf (nodeIdx) >= 0;
                }

            };
            $scope.processAtrribute = function(attr) {
              var returnVal;
              if(!attr) attr = {};
              if(attr.value){
                var newValue = attr.value;
                if(attr.type === 'Date'){
                  newValue = new Date ( Date.parse(attr.value));
                  var newLocaleValue = newValue.toLocaleString();
                  var dtList = newLocaleValue.split(',');
                  //if user has manually populated date/datetime in sfdc format, the below line wont work
                  //newLocaleValue = dtList[0].substring(0, dtList[0].length - 4) + dtList[0].substring(dtList[0].length - 2, dtList[0].length);
                  //return newLocaleValue;
                  //return dtList[0];
                  if (dtList.length>1)
                  {
                      return dtList[0];
                  }
                  else
                  {
                      returnVal = dtList[0].split(' ');
                      return returnVal[0];
                  }
                }else if(attr.type === 'Datetime'){
                  newValue = new Date ( Date.parse(attr.value));
                  var newLocaleValue = newValue.toLocaleString();
                  var dtList = newLocaleValue.split(',');
                  if (dtList.length>1)
                  {
                	  returnVal = dtList[0] + dtList[1].toString();
                  }
                  else
                  {
                      returnVal = dtList[0];
                  }
                  //if user has manually populated date/datetime in sfdc format, the below line wont work
                  //newLocaleValue = dtList[0].substring(0, dtList[0].length - 4) + dtList[0].substring(dtList[0].length - 2, dtList[0].length);
                  //newLocaleValue = newLocaleValue + dtList[1].substring(0, dtList[1].length - 6) + dtList[1].substring(dtList[1].length - 3, dtList[1].length);
                  //return newLocaleValue;
                  return returnVal;
                }
                else if(attr.type === 'Currency')
                {
                    return Number(attr.value).toFixed(2);
                }
                else if(attr.type === 'Number' || attr.type === 'Percent')
                {
                    var max = 20; // max number of digits after decimal places
                    var value = attr.value;
                    var s = value.toString().split('.');
                    if (s===Array && s.length ==1) {
                        if (s[1].length > max) {
                            return Number(value).toFixed(max).replace(/\.?0+$/,"");
                        } else {
                            return Number(value).toFixed(s[1].length).replace(/\.?0+$/,"");
                        }
                    } else {
                        return value;    
                    }
                }
                return newValue;
              }
              return "";
            };
            	
			$scope.highlightAttrNode = function(node, currentNodeId) {
				var targetElement;
				var attrNodeIdToHighlight = node.attrMappings[currentNodeId]!=null?node.attrMappings[currentNodeId].highlightId:
					                        (node.fieldMappings[currentNodeId]!=null?node.fieldMappings[currentNodeId]:null);
				if(attrNodeIdToHighlight!=null && document.getElementById(attrNodeIdToHighlight))
				{
					document.getElementById(attrNodeIdToHighlight).style = "color: blue; background:#C1DDF3;";
					targetElement = document.getElementById(attrNodeIdToHighlight);
					targetElement.style['color']= "blue";//#1dc0fa";
					targetElement.style['background'] = "#C1DDF3";//"#e5f8fe";
				}
				document.getElementById(currentNodeId).style="color: blue; background:#C1DDF3";
				targetElement = document.getElementById(currentNodeId);
				targetElement.style['color']= "blue";//#1dc0fa";
				targetElement.style['background'] = "#C1DDF3";//"#e5f8fe";
				$scope.isHighlighted = true;
				return node;
			};
			$scope.dehighlightAttrNode = function(node, currentNodeId)
			{
				var attrNodeIdToDehighlight = node.attrMappings[currentNodeId]!=null?node.attrMappings[currentNodeId].highlightId:
					                          (node.fieldMappings[currentNodeId]!=null?node.fieldMappings[currentNodeId]:null);
				
				if(attrNodeIdToDehighlight!=null && document.getElementById(attrNodeIdToDehighlight)!=null)
				{
					document.getElementById(attrNodeIdToDehighlight).style = "";
					targetElement = document.getElementById(attrNodeIdToDehighlight);
					targetElement.style['color']= "";
					targetElement.style['background'] = "";
				}
				document.getElementById(currentNodeId).style="";
				targetElement = document.getElementById(currentNodeId);
				targetElement.style['color']= "";
				targetElement.style['background'] = "";
				$scope.isHighlighted = false;
				return node;
			};
			
			/////////
            
			$scope.setDehighlightAttr = function(node){
				node.isHighlighted=false;
                if (node.nodes){
                	for (var i = 0; i < node.nodes.length; i++){
                		$scope.setDehighlightAttr (node.nodes[i]);
                	}
                }
                return node;
            };
            
			$scope.applyDehighlightStyles = function (){
				var temp, index, nodeToUpdate;
				var myHighlightedElements = document.getElementsByClassName('isHighlighted');
				while (myHighlightedElements!=null && myHighlightedElements.length>0){
					temp = myHighlightedElements[0];
					temp.style['border']= "";
					temp.style['background'] = "";
					temp.style['border-radius']="";
					temp.style = '';
                    console.log(temp.classList);
                    if (temp.classList.contains('isHighlighted')){
                    	//temp.classList.replace('isHighlighted', 'deHighlighted');
                    	temp.classList.remove('isHighlighted');
                    	temp.classList.add('deHighlighted');
                    }
				};
			};
			
			$scope.highlightNodes = function(node)
			{
				var nodeId = node.id;
				var tempFRlineId, targetElement;
				var targetElements = [];
				$scope.setDehighlightAttr($scope.orders);
				$scope.setDehighlightAttr($scope.frs);
				$scope.applyDehighlightStyles();
				if ((node.type==="Order Item" || node.type=='Fulfilment Request Line') && node.oiToFRLinesMap!=null && node.oiToFRLinesMap[nodeId]!=null)
				{
					for(var i=0; i<node.oiToFRLinesMap[nodeId].length; i++)
					{
						tempFRlineId = node.oiToFRLinesMap[nodeId][i];
						document.getElementById(tempFRlineId).style = "border: 3px solid #008ab3; background:#A0F3FF;border-radius:4px;";
						targetElement = document.getElementById(tempFRlineId);
						targetElement.style['border']= "3px solid #008ab3";//#d6e9e6";//#1dc0fa";
						targetElement.style['background'] = "#A0F3FF";//"#e5f8fe";
						targetElement.style['border-radius']="4px";

                        var highlightcount = targetElement.getAttribute("highlightcount");
                        if(highlightcount) {
                            highlightcount = parseInt(highlightcount) + 1;
                        } else {
                            highlightcount = 1;
                        }
                        targetElement.setAttribute("highlightcount", highlightcount);
                        if (targetElement.classList.contains('deHighlighted')){
                            //targetElement.classList.replace('deHighlighted', 'isHighlighted');
                            targetElement.classList.remove('deHighlighted');
                            targetElement.classList.add('isHighlighted');
                        }
                        else{
                        	targetElement.classList.add('isHighlighted');
                        }

                    }
					document.getElementById(nodeId).style="border: 3px solid #d6e9e6; background:#A0F3FF;border-radius:4px;";
					targetElement = document.getElementById(nodeId);
					targetElement.style['border']= "3px solid #008ab3";//#d6e9e6";//#1dc0fa";
					targetElement.style['background'] = "#A0F3FF";//"#e5f8fe";
					targetElement.style['border-radius']="4px";
					
					if (!(targetElement.classList.contains('isHighlighted'))){
                        targetElement.classList.add('isHighlighted');
                    }
					if (targetElement.classList.contains('deHighlighted')){
						targetElement.classList.remove('deHighlighted');
					}

				}
				node.isHighlighted=true;
				$scope.isHighlighted = true;
				return node;
			};
			$scope.dehighlightNode = function(node)
			{
				var nodeId = node.id;
				var tempFRlineId;
				if ((node.type==="Order Item" || node.type=='Fulfilment Request Line') && node.oiToFRLinesMap!=null && node.oiToFRLinesMap[nodeId]!=null)
				{
					for(var i=0; i<node.oiToFRLinesMap[nodeId].length; i++)
					{
						tempFRlineId = node.oiToFRLinesMap[nodeId][i];
						targetElement = document.getElementById(tempFRlineId);

                        var highlightcount = targetElement.getAttribute("highlightcount");

                        highlightcount = parseInt(highlightcount) - 1;
						targetElement.setAttribute("highlightcount", highlightcount);

                        //if(highlightcount == 0)
                        //{
                            document.getElementById(tempFRlineId).style = "";
                            targetElement.style['border']= "";
                            targetElement.style['background'] = "";
                            targetElement.style['border-radius']="";
						//}
                        if (targetElement.classList.contains('isHighlighted')){
                            //targetElement.classList.replace('isHighlighted', 'deHighlighted');
                            targetElement.classList.remove('isHighlighted');
                            targetElement.classList.add('deHighlighted');
                        }
					}
					document.getElementById(nodeId).style="";
					targetElement = document.getElementById(nodeId);
					targetElement.style['border']= "";
					targetElement.style['background'] = "";
					targetElement.style['border-radius']="";
					console.log('targetElement.classList:'+targetElement.classList);
					if (targetElement.classList.contains('isHighlighted')){
					    //targetElement.classList.replace('isHighlighted', 'deHighlighted');
					    targetElement.classList.remove('isHighlighted');
					    targetElement.classList.add('deHighlighted');
                    }
				}
                node.isHighlighted=false;
				$scope.isHighlighted = false;
				return node;
			};
			
			
			///////
      $scope.resolveNavigate = function(recordId)
      {
        console.log('resolveNavigate ' + recordId);
        var isExternalId = !isNaN(parseFloat(recordId)) && isFinite(recordId);
        if(!isExternalId)
        {
            window.open('/' + recordId);
        } else 
        {
            window.open('/apex/XOMObjectParams#!/object/' + recordId);
        }
      };

      $scope.resolveByGlobalKey = function(globalKey)
      {
        if(globalKey.indexOf('-') > -1)
        {
          console.log('Node.resolveByGlobalKey key ' + globalKey);
          remoteActions.getSfIdByGlobalKey(globalKey)
            .then(function(recordId)
              {
                console.log('Node.resolveByGlobalKey globalKey ' + globalKey + '. opening page in new window for object id ' + recordId);
                window.open('/' + recordId);
              });  
        } else {
          console.log('Node.resolveByGlobalKey object id ' + globalKey);
          window.open('/' + globalKey);
        }
      };
    }],
        compile: function(tElement, tAttr) {
            var contents = tElement.contents().remove();
            var compiledContents;
            return function(scope, iElement, iAttr) {
                if(!compiledContents) {
                    compiledContents = $compile(contents);
                }
                compiledContents(scope, function(clone, scope) {
                    iElement.append(clone);
                });
            };
        }

    };

}]);

},{}],3:[function(require,module,exports){
angular.module('vloc.xomNodeView').filter('linenumber', function () {
    return function(ln) {
        return ln.replace(/^[a-zA-Z][^.]*\./, '');
    };
});
},{}],4:[function(require,module,exports){
angular.module("vloc.xomNodeView").run(["$templateCache",function($templateCache){"use strict";$templateCache.put("NodeView.tpl.html",'<ul class="panel-group collapsibleList treeView" ng-model="parent.activeNodes" data-allow-multiple="true" bs-collapse \n    ng-repeat="node in parent.nodes" name="newList" id="{{node.id}}" ng-init="node.viewAttrPanel=true">\n    <div class="node outcome-wrapper">\n\t    <div class="node-title step-block slider" id="nodeHeader_{{node.id}}" \n\t         ng-class="{\'node-title-frLine\': node.type==\'Fulfilment Request\' || node.type==\'Fulfilment Request Line\'}">\n\t    <span class="correction">&nbsp;</span>\n\t    <span class="icon" \n\t          ng-class="{\'icon-v-right-arrow\': !node.isPanelExpanded,\'icon-v-down-arrow\': node.isPanelExpanded}" \n\t          aria-hidden="true" ng-click="togglePanel(node)"></span>\n\t    \n\t    \n\t    <i class="icon icon-v-link"\n\t       ng-show="((node.type==\'Order Item\' || node.type==\'Fulfilment Request Line\') && node.oiToFRLinesMap!=null && node.oiToFRLinesMap[node.id]!=null)" \n\t       ng-click="node.isHighlighted!=true? highlightNodes(node):dehighlightNode(node)"></i>\n\t       \n\t    <i class="icon icon-v-link" \n\t       ng-show="(node.type==\'Order Item\' && (node.oiToFRLinesMap==null || node.oiToFRLinesMap[node.id]==null))" \n\t       data-placement="right auto" bs-tooltip="getTooltip(\'{{node.name}} {{::$root.translatedLabels[\'XOMDecomNotAssoDownstreamProduct\']}}\', \'\')" \n         data-trigger="hover"></i>\n\t    <i ng-class="{\'icon icon-v-expand\':node.viewAttrPanel!=true, \'icon icon-v-collapse\':node.viewAttrPanel==true}"\n\t       ng-if="node.attrs!=null && node.attrs.length>0"\n\t       ng-click="node.viewAttrPanel=(!node.viewAttrPanel)"\n         data-placement="right auto" bs-tooltip="getTooltip(\'{{::$root.translatedLabels[\'XOMDecomShowHideAttriPanel\']}}\')"\n         data-trigger="hover"></i>\n\t    <a target="_blank" ng-click="resolveNavigate(node.id)" id="nodeName_{{node.id}}">\n        {{node.type==\'Order\' || node.type==\'Fulfilment Request\' ? (node.translatedType!=null?node.translatedType:node.type) +\':\': \'\'}} {{node.name}}  \n            <span class="node-subtitle" ng-if="node.type!=\'Order\' && node.type!=\'Fulfilment Request\'">\n                <span data-placement="top auto" bs-tooltip="{{getTooltip(node.name, linenumber)}}" ng-if="node.lineNumber" data-trigger="hover">({{node.lineNumber | linenumber}}</span>\n                <span ng-if="node.action!=null || node.subAction!=null">{{node.action!=null? \' / \'+node.action:\'\'}}{{node.subAction!=null? \' / \'+node.subAction:\'\'}})&lrm;</span>\n            </span>\n        </a>\n\t    </div>\n\t    <div class="node-content" ng-show=\'node.isPanelExpanded\'>\n\t    <li ng-class="{\'collapsibleListOpen\':isNodeActive(parent.activeNodes, $index),\'collapsibleListClosed\': !isNodeActive(parent.activeNodes, $index)}">\n               <div class="panel-collapse">\n                   <div class="fields">\n                       <div class="field" ng-repeat="field in node.fields" ng-if="field.value && !field.refId && field.name==\'Line Number\'" id="field_{{node.id}}_{{field.name}}">\n                           <span class="field-label">{{field.name}}:&nbsp;</span>\n                           <span class="field-value"  data-placement="top auto" bs-tooltip="getTooltip(field.value, linenumber)" data-trigger="hover">\n                           {{field.value | linenumber}}</span>\n                       </div>\n                       <div class="field" ng-repeat="field in node.fields" ng-if="field.value && !field.refId && field.name!=\'Line Number\'" id="field_{{node.id}}_{{field.name}}">\n                           <span class="field-label" ng-if="field.name == \'Status\'">{{::$root.translatedLabels[\'XOMDecomStatus\']}}:&nbsp;</span>\n                           <span class="field-label" ng-if="field.name != \'Status\'">{{field.name}}:&nbsp;</span>\n                           <span class="field-value"  \n                                 data-placement="top auto" bs-tooltip="getTooltip(field.value, \'\')" data-trigger="hover">{{field.value}}\n                           </span>\n                       </div>\n                       <div class="field" ng-repeat="field in node.fields" ng-if="field.value && !!field.refId" id="field_{{node.id}}_{{field.name}}">\n                           <span class="field-label">{{::$root.translatedLabels[\'XOMDecomProduct\']}}:&nbsp;</span>\n                           <span class="field-value" data-placement="top auto" bs-tooltip="getTooltip(field.value, \'\')" data-trigger="hover">\n                               <a target="_blank"  ng-click="resolveByGlobalKey(field.refId)">{{field.value}}</a>\n                           </span>\n                       </div>                       \n                       <div class="field" ng-if="node.assetId" id="field_{{node.id}}_{{field.name}}">\n                           <span class="field-label">{{::$root.translatedLabels[\'XOMDecomAssetInventoryItem\']}}:&nbsp;</span>\n                           <span class="field-value" data-placement="top auto" bs-tooltip="getTooltip(node.assetName, \'\')" data-trigger="hover">\n                               <a target="_blank"  ng-click="resolveNavigate(node.assetId)">{{node.assetName}}</a>\n                           </span>\n                       </div>\n                   </div>\n                   <div class="fields attrs">\n                       <div ng-repeat="attr in node.attrs" ng-if="attr.value && node.viewAttrPanel==true && (attr.hidden == \'false\' || attr.hidden == false)"\n                            class="field step-block slider" expand="expand" id="attr_{{node.specId}}_{{attr.name}}">\n                            <i class="icon icon-v-link"\n\t                          ng-show="(node.type==\'Fulfilment Request Line\'\n'+"\t                                   && ((node.attrMappings!=null &&  node.attrMappings['attr_'+node.specId+'_'+attr.name]!=null)\n\t                                   ||  (node.fieldMappings!=null && node.fieldMappings['attr_'+node.specId+'_'+attr.name]!=null)\n\t                                   ||  (node.staticMappings!=null && node.staticMappings['attr_'+node.specId+'_'+attr.name]!=null)))\"\n\t                          ng-mouseenter=\"highlightAttrNode(node, 'attr_'+node.specId+'_'+attr.name)\" \n\t                          ng-mouseleave=\"dehighlightAttrNode(node, 'attr_'+node.specId+'_'+attr.name)\"\n\t                          bs-tooltip=\"getRichTooltip(attr, 'processAtrribute', node)\"\n\t                          data-placement=\"right auto\" data-html=\"true\"></i>\n\t                        <i class=\"icon icon-v-check\"\n\t                          ng-show=\"(node.type=='Fulfilment Request Line'\n\t                                   && !(((node.attrMappings!=null &&  node.attrMappings['attr_'+node.specId+'_'+attr.name]!=null)\n\t                                   ||  (node.fieldMappings!=null && node.fieldMappings['attr_'+node.specId+'_'+attr.name]!=null)\n\t                                   ||  (node.staticMappings!=null && node.staticMappings['attr_'+node.specId+'_'+attr.name]!=null))))\"\n\t                          bs-tooltip=\"{title:'{{::$root.translatedLabels['XOMDecomDefaultValue']}}'}\"\n\t                          data-placement=\"right auto\" data-html=\"true\"></i>\n                           <span class=\"field-label\"\n                                 ng-class=\"{'defaultAttr':!(node.type=='Fulfilment Request Line'\n\t                                   && ((node.attrMappings!=null &&  node.attrMappings['attr_'+node.specId+'_'+attr.name]!=null)\n\t                                   ||  (node.fieldMappings!=null && node.fieldMappings['attr_'+node.specId+'_'+attr.name]!=null)\n\t                                   ||  (node.staticMappings!=null && node.staticMappings['attr_'+node.specId+'_'+attr.name]!=null)))}\">{{attr.name}}:&nbsp;</span>\n                           <span class=\"field-value\" data-placement=\"top auto\" \n                                 bs-tooltip=\"getTooltip(attr, 'processAtrribute')\" data-trigger=\"click hover\">{{processAtrribute(attr)}}\n                           </span>\n                       </div>\n                   </div>\n                   <node-view parent=\"node\" orders=\"orders\" frs=\"frs\"></node-view>\n               </div>\n           </div>\n        </li>\n        </div>\n     </div>\n</ul>")}]);
},{}]},{},[1]);

})();