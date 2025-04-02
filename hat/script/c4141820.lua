--儀式魔人プレコグスター
--Djinn Prognosticator of Rituals
function c4141820.initial_effect(c)
	--Can be used for a Ritual Summon from the GY
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_EXTRA_RITUAL_MATERIAL)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c4141820.con)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--Provc4141820e an effect to a Ritual monster
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c4141820.condition)
	e2:SetOperation(c4141820.operation)
	c:RegisterEffect(e2)
end
function c4141820.con(e)
	return not Duel.IsPlayerAffectedByEffect(e:GetHandlerPlayer(),CARD_SPIRIT_ELIMINATION)
end
function c4141820.condition(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_RITUAL
end
function c4141820.operation(e,tp,eg,ep,ev,re,r,rp)
	for rc in eg:Iter() do
		if rc:GetFlagEffect(c4141820)==0 then
			--Make the opponent discard 1 card
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetDescription(aux.Stringc4141820(c4141820,0))
			e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_BATTLE_DAMAGE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetLabel(ep)
			e1:SetCondition(c4141820.hdcon)
			e1:SetOperation(c4141820.hdop)
			e1:SetReset(RESET_EVENT|RESETS_STANDARD)
			rc:RegisterEffect(e1,true)
			rc:RegisterFlagEffect(c4141820,RESET_EVENT|RESETS_STANDARD,0,1)
		end
	end
end
function c4141820.hdcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==1-e:GetLabel() and eg:GetFirst()==e:GetHandler()
end
function c4141820.hdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,c4141820)
	Duel.DiscardHand(1-e:GetLabel(),nil,1,1,REASON_EFFECT+REASON_DISCARD)
end