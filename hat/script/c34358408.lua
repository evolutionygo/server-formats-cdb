--儀式魔人プレサイダー
--Djinn Presc34358408er of Rituals
function c34358408.initial_effect(c)
	--Can be used for a Ritual Summon while it is in the GY
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_EXTRA_RITUAL_MATERIAL)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c34358408.con)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--Grants an effect if it is used for a Ritual Summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c34358408.condition)
	e2:SetOperation(c34358408.operation)
	c:RegisterEffect(e2)
end
function c34358408.con(e)
	return not Duel.IsPlayerAffectedByEffect(e:GetHandlerPlayer(),CARD_SPIRIT_ELIMINATION)
end
function c34358408.condition(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_RITUAL
end
function c34358408.operation(e,tp,eg,ep,ev,re,r,rp)
	for rc in eg:Iter() do
		if rc:GetFlagEffect(c34358408)==0 then
			--Draw 1 card when a monster is destroyed by battle
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetDescription(aux.Stringc34358408(c34358408,0))
			e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
			e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_BATTLE_DESTROYING)
			e1:SetOperation(c34358408.drawop)
			e1:SetReset(RESET_EVENT|RESETS_STANDARD)
			rc:RegisterEffect(e1,true)
			rc:RegisterFlagEffect(c34358408,RESET_EVENT|RESETS_STANDARD,0,1)
		end
	end
end
function c34358408.drawop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
end