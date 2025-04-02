--ペンデュラム・シフト (Manga)
--Pendulum Transfer (Manga)
function c511015126.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511015126.target)
	e1:SetOperation(c511015126.activate)
	c:RegisterEffect(e1)
end
function c511015126.filter(c)
	return c:IsFaceup() and c:HasLevel()
end
function c511015126.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511015126.filter(chkc) end
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_PZONE,0) and Duel.CheckLocation(tp,LOCATION_PZONE,1)
		and Duel.IsExistingMatchingCard(c511015126.filter,tp,LOCATION_MZONE,0,2,nil) end
end
function c511015126.activate(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.CheckPendulumZones(tp) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local tg=Duel.SelectMatchingCard(tp,c511015126.filter,tp,LOCATION_MZONE,0,1,2,nil)
	local tc1=tg:GetFirst()
	local tc2=tg:GetNext()
	local typ1=tc1:Type()
	local typ2=tc2:Type()
	local rg={}
	if typ1&TYPE_PENDULUM==0 then
		Pendulum.AddProcedure(tc1,true)
		tc1:Type(typ1|TYPE_PENDULUM)
		rg[tc1]=true
	end
	if typ2&TYPE_PENDULUM==0 then
		Pendulum.AddProcedure(tc2,true)
		tc2:Type(typ2|TYPE_PENDULUM)
		rg[tc2]=true
	end 
	Duel.MoveToField(tc1,tp,tp,LOCATION_PZONE,POS_FACEUP,true)
	Duel.MoveToField(tc2,tp,tp,LOCATION_PZONE,POS_FACEUP,true)
	if rg[tc1] then
		tc1:Type(typ1)
	end
	if rg[tc2] then
		tc2:Type(typ2)
	end
	if tc1:GetLevel()>tc2:GetLevel() then tc1,tc2=tc2,tc1 end
	--set scales
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LSCALE)
	e1:SetValue(tc1:GetLevel()+tc2:GetLevel()+1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	tc1:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CHANGE_RSCALE)
	tc1:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetValue(tc2:GetLevel()-tc1:GetLevel())
	tc2:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CHANGE_RSCALE)
	tc2:RegisterEffect(e4)
end