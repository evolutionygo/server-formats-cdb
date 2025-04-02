--儀式魔人カースエンチャンター
--Djinn Cursenchanter of Rituals
function c77153811.initial_effect(c)
	--Can be used for a Ritual while it is in the GY
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_EXTRA_RITUAL_MATERIAL)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c77153811.con)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--Grant an effect if it is used for a Ritual Summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c77153811.condition)
	e2:SetOperation(c77153811.operation)
	c:RegisterEffect(e2)
end
function c77153811.con(e)
	return not Duel.IsPlayerAffectedByEffect(e:GetHandlerPlayer(),CARD_SPIRIT_ELIMINATION)
end
function c77153811.condition(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_RITUAL
end
function c77153811.operation(e,tp,eg,ep,ev,re,r,rp)
	for rc in eg:Iter() do
		if rc:GetFlagEffect(c77153811)==0 then
			--Negate the effects of Synchro monsters
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetDescription(aux.Stringc77153811(c77153811,0))
			e1:SetCode(EFFECT_DISABLE)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
			e1:SetRange(LOCATION_MZONE)
			e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
			e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_SYNCHRO))
			e1:SetReset(RESET_EVENT|RESETS_STANDARD)
			rc:RegisterEffect(e1,true)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e2:SetCode(EVENT_CHAIN_SOLVING)
			e2:SetRange(LOCATION_MZONE)
			e2:SetOperation(c77153811.disop)
			e2:SetReset(RESET_EVENT|RESETS_STANDARD)
			rc:RegisterEffect(e2,true)
			rc:RegisterFlagEffect(c77153811,RESET_EVENT|RESETS_STANDARD,0,1)
		end
	end
end
function c77153811.disop(e,tp,eg,ep,ev,re,r,rp)
	if re:IsActiveType(TYPE_SYNCHRO) then
		Duel.NegateEffect(ev)
	end
end