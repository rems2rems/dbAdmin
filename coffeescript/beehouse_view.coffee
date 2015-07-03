module.exports = (beehouse_id)->
	return {
	    _id : '_design/' + beehouse._id
	    views :

	        weight :

	            map : ((doc)-> 
	                if doc.type is "measure" and doc.name is "global-weight" and doc.beehouse_id is "id_placeholder"
	                    
	                    emit(doc.timestamp, doc)

	                ).toString().replace("id_placeholder",beehouse._id)

	        morning_weight :

	            map : ((doc)-> 

	                if doc.type is "measure" and doc.name is "global-weight" and doc.beehouse_id is "id_placeholder"
	                    
	                    timestamp = new Date(doc.timestamp)

	                    if timestamp.getHours() is 7

	                        tokens = doc.timestamp.split("T")
	                        time = tokens[0] + "T" + tokens[1].split(":")[0]
	                        emit(time, [doc.value,1])

	                ).toString().replace("id_placeholder",beehouse._id)

	            reduce : ((key,values)->

	                #time = values[0][0]
	                weights = values.map (v)-> v[0]
	                factors = values.map (v)-> v[1]
	                totalFactors = sum(factors)
	                
	                totalWeight = 0
	                for weight,i in weights
	                    totalWeight += weight*factors[i]
	                totalWeight = totalWeight/totalFactors
	                
	                return [totalWeight,totalFactors]

	                ).toString()

	        evening_weight :

	            map : ((doc)-> 

	                if doc.type is "measure" and doc.name is "global-weight" and doc.beehouse_id is "id_placeholder"
	                    
	                    timestamp = new Date(doc.timestamp)

	                    if timestamp.getHours() is 21

	                        tokens = doc.timestamp.split("T")
	                        time = tokens[0] + "T" + tokens[1].split(":")[0]
	                        emit(time, [doc.value,1])

	                ).toString().replace("id_placeholder",beehouse._id)

	            reduce : ((key,values)->

	                #time = values[0][0]
	                weights = values.map (v)-> v[0]
	                factors = values.map (v)-> v[1]
	                totalFactors = sum(factors)
	                
	                totalWeight = 0
	                for weight,i in weights
	                    totalWeight += weight*factors[i]
	                totalWeight = totalWeight/totalFactors
	                
	                return [totalWeight,totalFactors]

	                ).toString()

	        weight_by_week :

	            map : ((doc)-> 
	                if doc.type is "measure" and doc.name is "global-weight" and doc.beehouse_id is "id_placeholder"
	                    
	                    day = new Date(doc.timestamp)
	                    day.setHours(0,0,0)
	                    
	                    day.setDate(day.getDate() + 4 - (day.getDay()||7))
	                    yearStart = new Date(day.getFullYear(),0,1)
	                    weekNo = Math.ceil(( ( (day - yearStart) / 86400000) + 1)/7)
	                    
	                    tag = yearStart.getFullYear() + "W" + ("0" + weekNo).slice(-2)
	                    
	                    emit(tag, [doc.value,1])

	                ).toString().replace("id_placeholder",beehouse._id)

	            reduce : ((key,values)->

	                #time = values[0][0]
	                weights = values.map (v)-> v[0]
	                factors = values.map (v)-> v[1]
	                totalFactors = sum(factors)
	                
	                totalWeight = 0
	                for weight,i in weights
	                    totalWeight += weight*factors[i]
	                totalWeight = totalWeight/totalFactors
	                
	                return [totalWeight,totalFactors]

	                ).toString()
	}