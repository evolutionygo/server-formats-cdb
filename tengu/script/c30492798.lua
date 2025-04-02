--儀式魔人ディザーズ
--Djinn Disserere of Rituals
function c30492798.initial_effect(c)
	--Can be used for a Ritual Summon while it is in the GY
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_EXTRA_RITUAL_MATERIAL)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c30492798.con)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--A ritual monster using this card is unaffected by traps
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c30492798.condition)
	e2:SetOperation(c30492798.operation)
	c:RegisterEffect(e2)
end
function c30492798.con(e)
	return not Duel.IsPlayerAffectedByEffect(e:GetHandlerPlayer(),CARD_SPIRIT_ELIMINATION)
end
function c30492798.condition(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_RITUAL
end
function c30492798.operation(e,tp,eg,ep,ev,re,r,rp)
	for rc in eg:Iter() do
		if rc:GetFlagEffect(c30492798)==0 then
			--Unaffected by traps
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetDescription(3103)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CLIENT_HINT)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCode(EFFECT_IMMUNE_EFFECT)
			e1:SetReset(RESET_EVENT|RESETS_STANDARD)
			e1:SetValue(c30492798.efilter)
			rc:RegisterEffect(e1,true)
			rc:RegisterFlagEffect(c30492798,RESET_EVENT|RESETS_STANDARD,0,1)
		end
	end
end
function c30492798.efilter(e,te)
	return te:IsTrapEffect()
end