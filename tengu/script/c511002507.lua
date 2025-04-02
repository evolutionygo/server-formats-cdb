--水魔神－スーガ (Anime)
--Suijin (Anime)
function c511002507.initial_effect(c)
	--Place  itself in the Spell/Trap Zone
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511002507(c511002507,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1)
	e1:SetTarget(c511002507.settg)
	e1:SetOperation(c511002507.setop)
	c:RegisterEffect(e1)
	--Negate the attack of an opponent's monster
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511002507(c511002507,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetOperation(c511002507.operation)
	c:RegisterEffect(e2)
	--Changet its ATK
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc511002507(c511002507,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511002507.atkcon)
	e3:SetTarget(c511002507.atktg)
	e3:SetOperation(c511002507.atkop)
	c:RegisterEffect(e3)
end
c511002507.listed_names={62340868,25955164}
--place in Szone
function c511002507.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsLocation(LOCATION_HAND) and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c511002507.setop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsImmuneToEffect(e) or not c:IsLocation(LOCATION_HAND) then return end
	if not Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true) then return end
end
--negate attack
function c511002507.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
--atk change
function c511002507.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetAttacker()==e:GetHandler()
end
function c511002507.atkfilter(c,code1,code2)
	return (c:IsCode(code1) or c:IsCode(code2)) and c:IsMonster()
end
function c511002507.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(c511002507)==0
		and (Duel.IsExistingMatchingCard(c511002507.atkfilter,tp,LOCATION_MZONE,0,1,nil,62340868,25955164)) end
	e:GetHandler():RegisterFlagEffect(c511002507,RESET_CHAIN,0,1)
end
function c511002507.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.GetMatchingGroup(c511002507.atkfilter,tp,LOCATION_MZONE,0,nil,62340868,25955164)
	local sg=aux.SelectUnselectGroup(g,e,tp,1,2,aux.dncheck,1,tp,HINTMSG_TARGET)
	if #sg>0 then
		local atk=(c:GetAttack()+(sg:GetSum(Card.GetAttack)))/2
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(atk)
		c:RegisterEffect(e1)
		for tc in sg:Iter() do
			local e0=Effect.CreateEffect(c)
			e0:SetType(EFFECT_TYPE_SINGLE)
			e0:SetCode(EFFECT_CANNOT_ATTACK)
			e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e0:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e0)
		end
	end
end