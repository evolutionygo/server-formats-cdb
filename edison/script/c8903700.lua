--儀式魔人リリーサー
--Djinn Releaser of Rituals
function c8903700.initial_effect(c)
	--Can be used for a Ritual Summon while it is in the GY
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_EXTRA_RITUAL_MATERIAL)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c8903700.con)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--Provc8903700e an effect to the Ritual monster summoned with this
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c8903700.condition)
	e2:SetOperation(c8903700.operation)
	c:RegisterEffect(e2)
end
function c8903700.con(e)
	return not Duel.IsPlayerAffectedByEffect(e:GetHandlerPlayer(),CARD_SPIRIT_ELIMINATION)
end
function c8903700.condition(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_RITUAL
end
function c8903700.operation(e,tp,eg,ep,ev,re,r,rp)
	for rc in eg:Iter() do
		if rc:GetFlagEffect(c8903700)==0 then
			--The opponent cannot Special Summon
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetDescription(aux.Stringc8903700(c8903700,0))
			e1:SetProperty(EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_PLAYER_TARGET)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
			e1:SetReset(RESET_EVENT|RESETS_STANDARD)
			e1:SetAbsoluteRange(ep,0,1)
			rc:RegisterEffect(e1,true)
			rc:RegisterFlagEffect(c8903700,RESET_EVENT|RESETS_STANDARD,0,1)
		end
	end
end