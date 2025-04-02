--ダーク・サンクチュアリ
--Dark Sanctuary
function c511000119.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c511000119.condition)
	e1:SetTarget(c511000119.target)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_BECOME_QUICK)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetDescription(aux.Stringc511000119(c511000119,1))
	e3:SetCode(EFFECT_QP_ACT_IN_SET_TURN)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetDescription(aux.Stringc511000119(c511000119,1))
	e4:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	c:RegisterEffect(e4)
	--
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetRange(LOCATION_FZONE)
	e5:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	e5:SetCountLimit(1)
	e5:SetOperation(c511000119.regop)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_EQUIP)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(c511000119)
	e6:SetCondition(c511000119.eqcon)
	e6:SetTarget(c511000119.eqtg)
	e6:SetOperation(c511000119.operation)
	c:RegisterEffect(e6)
	--destroy
	local e7=Effect.CreateEffect(c)
	e7:SetCategory(CATEGORY_DAMAGE+CATEGORY_RECOVER)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e7:SetCode(EVENT_ATTACK_ANNOUNCE)
	e7:SetRange(LOCATION_FZONE)
	e7:SetCondition(c511000119.atkcon)
	e7:SetTarget(c511000119.atktg)
	e7:SetOperation(c511000119.atkop)
	c:RegisterEffect(e7)
	--move
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD)
	e8:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e8:SetCode(EFFECT_SPSUMMON_PROC_G)
	e8:SetRange(LOCATION_FZONE)
	e8:SetCondition(c511000119.movecon)
	e8:SetOperation(c511000119.moveop)
	c:RegisterEffect(e8)
	--copy
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e9:SetCode(EVENT_ADJUST)
	e9:SetRange(LOCATION_FZONE)
	e9:SetOperation(c511000119.activ)
	c:RegisterEffect(e9)
	--maintain
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e10:SetCode(EVENT_PHASE+PHASE_END)
	e10:SetRange(LOCATION_FZONE)
	e10:SetCountLimit(1)
	e10:SetCondition(c511000119.mtcon)
	e10:SetOperation(c511000119.mtop)
	c:RegisterEffect(e10)
end
c511000119.listed_names={CARD_DESTINY_BOARD,31829185}
function c511000119.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsCode,1,nil,31829185)
end
function c511000119.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return true end
	if c:IsLocation(LOCATION_FZONE) and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,31829185) and Duel.SelectEffectYesNo(tp,c) then
		e:SetCategory(CATEGORY_EQUIP)
		Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
		e:SetOperation(c511000119.operation)
	else
		e:SetCategory(0)
		e:SetProperty(0)
		e:SetOperation(nil)
	end
end
function c511000119.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local tc=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil):GetFirst()
		if tc then
			Duel.Equip(tp,c,tc)
			--equip limit
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetValue(1)
			e1:SetReset(RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_END)
			c:RegisterEffect(e1)
			--end
			local e2=Effect.CreateEffect(c)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IMMEDIATELY_APPLY)
			e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e2:SetRange(LOCATION_FZONE)
			e2:SetCountLimit(1)
			e2:SetCode(EVENT_PHASE+PHASE_END)
			e2:SetOperation(c511000119.op)
			e2:SetReset(RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_END)
			c:RegisterEffect(e2)
			c:RegisterFlagEffect(511000118,RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_END,0,1)
		end
	end
end
function c511000119.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.SendtoDeck(c,nil,-2,REASON_EFFECT)
	Duel.MoveToField(c,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
end
function c511000119.regop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RaiseSingleEvent(e:GetHandler(),c511000119,e,0,tp,tp,0)
end
function c511000119.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsTurnPlayer(1-tp) and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,31829185)
end
function c511000119.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511000119.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetEquipTarget()
	return tc and Duel.GetAttacker()==tc and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,31829185)
end
function c511000119.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local a=Duel.GetAttacker()
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,a:GetAttack()/2)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,a:GetAttack()/2)
end
function c511000119.atkop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local tc=e:GetHandler():GetEquipTarget()
	if not a or not tc or a~=tc then return end
	Duel.NegateAttack()
	local atk=a:GetAttack()
	local val=Duel.Damage(1-tp,atk/2,REASON_EFFECT)
	if val>0 then
		Duel.Recover(tp,val,REASON_EFFECT)
	end
end
function c511000119.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,31829185)
		and e:GetHandler():GetFlagEffect(511000118)==0
end
function c511000119.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.CheckReleaseGroup(tp,nil,1,nil) and Duel.SelectYesNo(tp,aux.Stringc511000119(c511000119,0)) then
		local sg=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
		Duel.Release(sg,REASON_COST)
	else
		Duel.Destroy(e:GetHandler(),REASON_RULE)
	end
end
function c511000119.mvfilter(c,tp)
	if c:IsFacedown() or not c:IsCode(31893528,67287533,94772232,30170981) then return false end
	if c:IsLocation(LOCATION_MZONE) then
		return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
	else
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	end
end
function c511000119.movecon(e,c,og)
	if c==nil then return true end
	return Duel.IsExistingMatchingCard(c511000119.mvfilter,c:GetControler(),LOCATION_ONFIELD,0,1,nil,c:GetControler())
end
function c511000119.moveop(e,tp,eg,ep,ev,re,r,rp,c,og)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local tc=Duel.SelectMatchingCard(tp,c511000119.mvfilter,tp,LOCATION_ONFIELD,0,1,1,nil,tp):GetFirst()
	if tc then
		if tc:IsLocation(LOCATION_MZONE) then
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		else
			Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
			--immune
			local e4=Effect.CreateEffect(c)
			e4:SetType(EFFECT_TYPE_SINGLE)
			e4:SetCode(EFFECT_IMMUNE_EFFECT)
			e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e4:SetRange(LOCATION_MZONE)
			e4:SetValue(c511000119.efilter)
			e4:SetReset(RESET_EVENT|RESET_TOGRAVE|RESET_REMOVE|RESET_TEMP_REMOVE|RESET_TOHAND|RESET_TODECK|RESET_OVERLAY)
			tc:RegisterEffect(e4,true)
			--cannot be battle target
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e2:SetRange(LOCATION_MZONE)
			e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
			e2:SetValue(aux.imval1)
			e2:SetReset(RESET_EVENT|RESET_TOGRAVE|RESET_REMOVE|RESET_TEMP_REMOVE|RESET_TOHAND|RESET_TODECK|RESET_OVERLAY)
			tc:RegisterEffect(e2,true)
			--Direct attack
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_FIELD)
			e3:SetCode(EFFECT_DIRECT_ATTACK)
			e3:SetRange(LOCATION_MZONE)
			e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
			e3:SetTarget(c511000119.dirtg)
			e3:SetReset(RESET_EVENT|RESET_TOGRAVE|RESET_REMOVE|RESET_TEMP_REMOVE|RESET_TOHAND|RESET_TODECK|RESET_OVERLAY)
			tc:RegisterEffect(e3,true)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_ATTACK)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT|RESET_TOGRAVE|RESET_REMOVE|RESET_TEMP_REMOVE|RESET_TOHAND|RESET_TODECK|RESET_OVERLAY)
			tc:RegisterEffect(e1,true)
			tc:RegisterFlagEffect(c511000119,RESET_EVENT|RESETS_STANDARD,0,1)
		end
	end
	return
end
function c511000119.efilter(e,te)
	local tc=te:GetOwner()
	return tc~=e:GetOwner() and not tc:IsCode(CARD_DESTINY_BOARD)
end
function c511000119.dirtg(e,c)
	return not Duel.IsExistingMatchingCard(aux.FilterEqualFunction(Card.GetFlagEffect,0,c511000119),c:GetControler(),0,LOCATION_MZONE,1,nil)
end
function c511000119.filter(c)
	return (c:IsNormalSpell() or c:IsQuickPlaySpell()) and c:GetActivateEffect()
		and c:GetFlagEffect(c511000119+1)==0
end
function c511000119.activ(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511000119.filter,tp,LOCATION_HAND,0,nil)
	local tc=g:GetFirst()
	while tc do
		if tc:GetFlagEffect(c511000119+1)==0 then
			local te=tc:GetActivateEffect()
			local e1=Effect.CreateEffect(tc)
			e1:SetCategory(te:GetCategory())
			e1:SetType(EFFECT_TYPE_ACTIVATE)
			if tc:GetType()==TYPE_SPELL then
				e1:SetCode(EVENT_FREE_CHAIN)
			else
				e1:SetCode(te:GetCode())
			end
			e1:SetProperty(te:GetProperty())
			e1:SetCondition(c511000119.con)
			e1:SetCost(c511000119.cos)
			e1:SetTarget(c511000119.tar)
			e1:SetOperation(te:GetOperation())
			e1:SetRange(LOCATION_HAND)
			e1:SetValue(LOCATION_MZONE)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(c511000119+1,RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_END,0,1)
		end
		tc=g:GetNext()
	end
end
function c511000119.con(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetHandler():GetActivateEffect()
	local condition=te:GetCondition()
	return (not condition or condition(e,tp,eg,ep,ev,re,r,rp)) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetLocationCount(tp,LOCATION_SZONE)<=0
end
function c511000119.cos(e,tp,eg,ep,ev,re,r,rp,chk)
	local te=e:GetHandler():GetActivateEffect()
	local co=te:GetCost()
	if chk==0 then return not co or co(e,tp,eg,ep,ev,re,r,rp,0) end
	if co then co(e,tp,eg,ep,ev,re,r,rp,1) end
end
function c511000119.tar(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local te=c:GetActivateEffect()
	local tg=te:GetTarget()
	local op=te:GetOperation()
	if chk==0 then return (not tg or tg(e,tp,eg,ep,ev,re,r,rp,0)) and Duel.GetTurnPlayer()==tp
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,31829185)
	end
	c:CreateEffectRelation(e)
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1,nil) end
	e:SetOperation(op)
end